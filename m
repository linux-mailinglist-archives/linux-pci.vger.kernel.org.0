Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465DF6049F7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 16:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiJSOyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 10:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiJSOyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 10:54:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548EC14BB65;
        Wed, 19 Oct 2022 07:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A19B824AF;
        Wed, 19 Oct 2022 14:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3DDC433B5;
        Wed, 19 Oct 2022 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666190721;
        bh=cyo3xHL7zh2O3ezCkRHW2ElVMHL4kgPd1Sf8hBtNTNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MukjbEopHqhKSb50i8g2SiVr+xXzwqrl6puA0y151Z7M7Wal7oTYoiWP1RHunNDJw
         x/a9vPKIut2WhBoq7hdDYJylaTf7F/rJlspEor39+sXFsxAO2ii03y7wS4bI9keBY6
         82/PVeBTuSg1251LZTgYhAXcOiq0eP6ZqOxrdk1DEPVcPKuptOPTgKXgxZPxNiiq1R
         DgsCmc8CDV7lfGPhMfOXJMA9ZrcjcsRLQEDI/cFccmtuqvW0ju8hDJX2GvAxuG6gr2
         U3a4J4typiFcO74P4u4NozprtCNMqzGxrMoaFXT3Oj/as80G0hbbWmD9bSvBNvUATX
         9axo/hj0bj4Lw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1olAJh-0003H9-4i; Wed, 19 Oct 2022 16:45:09 +0200
Date:   Wed, 19 Oct 2022 16:45:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <Y1ANdVT+arvotzzX@hovoldconsulting.com>
References: <20221017112449.2146-1-johan+linaro@kernel.org>
 <20221017112449.2146-3-johan+linaro@kernel.org>
 <Y1AKiTkLa23idaf2@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1AKiTkLa23idaf2@x1>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 19, 2022 at 10:32:41AM -0400, Brian Masney wrote:
> On Mon, Oct 17, 2022 at 01:24:49PM +0200, Johan Hovold wrote:
> > +	/*
> > +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> > +	 * to be set before enabling interconnect clocks.
> > +	 *
> > +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> > +	 * for the pcie-mem path.
> > +	 */
> > +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> 
> [snip]
> 
> > +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> > +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> > +
> > +	switch (speed) {
> > +	case 1:
> > +		bw = MBps_to_icc(250);
> > +		break;
> > +	case 2:
> > +		bw = MBps_to_icc(500);
> > +		break;
> > +	default:
> > +	case 3:
> > +		bw = MBps_to_icc(985);
> > +		break;
> > +	}
> 
> Just curious: These platforms have a 4 lane PCIe bus. Why use 985
> instead of 1000 for the maximum?

This is the per-lane bandwidth that depends on encoding. The four-lane
peak throughput would be about 3.94 GB/s.

Johan

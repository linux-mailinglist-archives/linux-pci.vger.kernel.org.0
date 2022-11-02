Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C56615E20
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 09:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiKBIpT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKBIpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 04:45:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6525291;
        Wed,  2 Nov 2022 01:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CA49B82151;
        Wed,  2 Nov 2022 08:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE301C433D6;
        Wed,  2 Nov 2022 08:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667378713;
        bh=TvEg9RB3Oul1rtDnkJ2s5m8u0GLPILFvqGgTjZSUFXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umdY0OrZWjyQFKdiNdjYhUW9pUavikR/U+u1k1JG/X0c/ZxGFt4/ZNSrLG+MB8s/6
         KbKnSI/hWxEZK7c4tTQYZ7CTGor9yUkFvFRn9syFZGxhUZizf//AtIwvtb9rFd0Feq
         Duk6lu8B58p7glXykUAhtxgDOMtV7PuhVDppa+sIGZBr28DieQgsYyY39rpKhp+SEX
         oGEKCZ/xxCTpOQ7MhUAJiQAPkZvQtAh/XtCbLTfjuYlQCDnt517tGqJBh25+RMRMtG
         DYAd4SZvpC5+SNW8PhexrTa6PcwquFj90Rx+Is+IWl2f04jAGjiphbBQqwqxaT2rem
         7tzWPbKLef4Rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oq9Mm-0003uT-Vn; Wed, 02 Nov 2022 09:44:57 +0100
Date:   Wed, 2 Nov 2022 09:44:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
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
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        quic_vbadigan@quicinc.com, Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add basic interconnect support
Message-ID: <Y2IuCFtbiw4H+T0C@hovoldconsulting.com>
References: <20221021064616.6380-1-johan+linaro@kernel.org>
 <20221021064616.6380-3-johan+linaro@kernel.org>
 <20221101143529.GA244012@thinkpad>
 <Y2IshhNv6JlhCbkp@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IshhNv6JlhCbkp@hovoldconsulting.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 09:38:31AM +0100, Johan Hovold wrote:
> On Tue, Nov 01, 2022 at 08:05:29PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Oct 21, 2022 at 08:46:16AM +0200, Johan Hovold wrote:
> > > On Qualcomm platforms like SC8280XP and SA8540P, interconnect bandwidth
> > > must be requested before enabling interconnect clocks.
> > > 
> > > Add basic support for managing an optional "pcie-mem" interconnect path
> > > by setting a low constraint before enabling clocks and updating it after
> > > the link is up.
> > > 
> > > Note that it is not possible for a controller driver to set anything but
> > > a maximum peak bandwidth as expected average bandwidth will vary with
> > > use case and actual use (and power policy?). This very much remains an
> > > unresolved problem with the interconnect framework.
> > > 
> > > Also note that no constraint is set for the SC8280XP/SA8540P "cpu-pcie"
> > > path for now as it is not clear what an appropriate constraint would be
> > > (and the system does not crash when left unspecified).

> > > +	}
> > > +
> > > +	/*
> > > +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> > > +	 * to be set before enabling interconnect clocks.
> > > +	 *
> > > +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> > > +	 * for the pcie-mem path.
> > > +	 */
> > > +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> > > +			ret);
> > 
> > Move "ret);" to prior line. No need to keep up within 80 columns.
> 
> 80 chars is still a soft limit and in this case there's no real gain in
> terms of readability from breaking it.
> 
> But sure, I can remove the line break.

After looking at the result, I changed my mind here and will stick to
the 80 char limit.

Johan

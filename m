Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90552BCD7
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 16:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiERNYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiERNYH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 09:24:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98A14AF58;
        Wed, 18 May 2022 06:24:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D137268AFE; Wed, 18 May 2022 15:23:58 +0200 (CEST)
Date:   Wed, 18 May 2022 15:23:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add system PM support
Message-ID: <20220518132358.GA26902@lst.de>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org> <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 06:49:13PM +0530, Manivannan Sadhasivam wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> Add suspend and resume callbacks to handle system suspend and resume in
> the Qcom PCIe controller driver. When the system suspends, PME turnoff
> message will be sent to the device and the RC driver will wait for the
> device to enter L23 Ready state. After that, the PHY will be powered down
> and clocks/regulators will be disabled.

So what about just not doing this stupid power disabling to start
with?  Unlike x86 where we do not have choice due to the BIOS, we
apparently do here.  And disabling power is the wrong thing to do at
least for SSDs as it massively increases the wear on the NAND.

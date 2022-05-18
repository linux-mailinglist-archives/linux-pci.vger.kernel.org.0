Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A1752B565
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiERIoE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiERIoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 04:44:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7F31339D2;
        Wed, 18 May 2022 01:44:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F149768AFE; Wed, 18 May 2022 10:43:56 +0200 (CEST)
Date:   Wed, 18 May 2022 10:43:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for
 SC7280
Message-ID: <20220518084356.GA6933@lst.de>
References: <20220513110027.31015-3-manivannan.sadhasivam@linaro.org> <20220516201950.GA1047412@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516201950.GA1047412@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> No doubt "power ... will be taken off during system suspend" is true,
> but this isn't very informative.  Is this a property of SC7280?  A
> choice made by the SC7280 driver?  Why is this not applicable to other
> systems?

This is really braindamage inflicted by microsoft with the StorageD3
property on ACPI systems.  It is in general a really, really bad idea
as it saves a little power but massively wears out the flash.  It seems
like Chromebooks and DT just want to keep up with the Jones.

Which is a reminder that we should probably integrate the StorageD3
handling into this framework.

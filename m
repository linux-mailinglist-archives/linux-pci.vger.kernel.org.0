Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A7527D1F
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 07:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiEPFov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 01:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiEPFot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 01:44:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011DDFC2;
        Sun, 15 May 2022 22:44:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6A4E68B05; Mon, 16 May 2022 07:44:42 +0200 (CEST)
Date:   Mon, 16 May 2022 07:44:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me
Subject: Re: [PATCH 0/3] PCI: Notify PCI drivers about powerdown during
 suspend
Message-ID: <20220516054442.GA12171@lst.de>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This looks workable to me, and is fine with me from the NVMe side.
I could see arguments for passing the flag to the actual suspend
method, but as that would require much bigger changes I'm not going
to ask for it just because.

Acked-by: Christoph Hellwig <hch@lst.de>

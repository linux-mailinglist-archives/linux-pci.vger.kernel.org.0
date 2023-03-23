Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10C16C5DD8
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjCWEQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 00:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCWEQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 00:16:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE233C06
        for <linux-pci@vger.kernel.org>; Wed, 22 Mar 2023 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NRFc5B+SG1Cg3baSTTty4FeqVBlBbRnV1e8jPDxbED8=; b=XTs5iGoURM8+A/DwqzobAUDDFz
        6JDMwRpnbB4XLwmpgR8rYY7bNcsS3svTF6KGSu3dNqiRTSSViJ5Fhmq4Y354dIh7TGbqRaxjLYAjq
        3tnFeyVT55GAOhJ1Ttd/NSGOcbhRZoIRzHqbqNFJoN/j+42zp4cmsMx5BGyPKoQAmb5Fea0vqPoXf
        OvjIIlWCb10eqJlJSdlFYaG+M7kvEE5AixT/lC+/nYN7ZjKQhGMsBKfBqtGmwvI3WuZ1vJvFg7jOO
        vlNC9r0YIa9oAIBTZzP/ZOBomareZVzJIlJYZBgX+mLif0B9lUDXz23gF4SpVWBeDw8aCpdMZ97LM
        TDMoy21w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfCNA-000jA5-39;
        Thu, 23 Mar 2023 04:16:20 +0000
Date:   Wed, 22 Mar 2023 21:16:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-pci@vger.kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Jon Nettleton <jon@solid-run.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: Samsung PM991 NVME does not work on LX2160A system (Solidrun
 Honeycomb)
Message-ID: <ZBvSlHfXcX+oII5q@infradead.org>
References: <a1a1d17b-94fd-b53d-0850-c8f27440f0bd@linaro.org>
 <20230320161100.GA2292748@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320161100.GA2292748@bhelgaas>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 11:11:00AM -0500, Bjorn Helgaas wrote:
> > The problem is that I am unable to use Samsung PM991 NVME there.
> > It is 2242 card so probably also DRAMless. Kernel says:
> > 
> > nvme 0004:01:00.0: Adding to iommu group 4
> > nvme nvme0: pci function 0004:01:00.0
> > nvme nvme0: missing or invalid SUBNQN field.
> > nvme nvme0: 1/0/0 default/read/poll queues
> > nvme 0004:01:00.0: VPD access failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

I have no idea who even does the PCI vpd accesses here, but either
way there's not much we can do from the nvme driver side.

> > The SUBNQN part can be handled by adding quirk in nvme/core.c file
> > but that does not change situation. It also does not appear when
> > used in x86-64 system.

Although this suggests something is fishy with the config space
implementation for this particular hardware, and NVMe just happens
to trip it.

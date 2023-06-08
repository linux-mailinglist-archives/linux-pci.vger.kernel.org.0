Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACB727ADC
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 11:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjFHJLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 05:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFHJLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 05:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A97E7;
        Thu,  8 Jun 2023 02:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F7B061A21;
        Thu,  8 Jun 2023 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AE2C433EF;
        Thu,  8 Jun 2023 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686215471;
        bh=TkoZu+Gddauql3to8E6r++VcgqF/WSm1eT1Il4za0to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfcYQpDOjIlDOxp4KZ9MV4WNJ96DSAgWHDHqmWHHqX/+2Zg0cUVJUW3vH7dQx/xQE
         EyndX5A9cqwFbtfSP6Ga40YUhLvi+aZaSwwCIsujuxPnmtQpUPS36urLR7x76QDRuw
         M5XX0D0WPyQf+ASlKmLyKKGb0Kqsp9grqubXL0jQ=
Date:   Thu, 8 Jun 2023 11:11:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
Message-ID: <2023060817-tinker-reaction-bbe1@gregkh>
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
 <2023051843-scruffy-gush-cdec@gregkh>
 <aeaebb8c-e077-4678-62df-d80baff16347@loongson.cn>
 <ad9bfa94-1372-4810-734e-0bbaace37553@loongson.cn>
 <2023060827-overlaid-displace-b3a1@gregkh>
 <f086572b-d7c3-43f2-073e-ec35392bdc55@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f086572b-d7c3-43f2-073e-ec35392bdc55@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 04:57:04PM +0800, zhuyinbo wrote:
> 
> 
> 在 2023/6/8 下午4:01, Greg Kroah-Hartman 写道:
> > On Thu, Jun 08, 2023 at 03:54:36PM +0800, zhuyinbo wrote:
> > > 
> > > Friendly ping ?
> > 
> > For what?  I thought a new series was going to be submitted, I don't
> > have anything in my queue to review for this at the moment.
> 
> 
> I have some comments that need your consent or opinion.
> such as, I have a explanation why I using pci_match_id() in
> dwc2/params.c.  Do you agree with my explanation ?

I have no context here, sorry.  Remember, we review hundreds of patches
a week, when you cut off all context that makes it impossible to
remember.

Submit your updated patchset based on what you feel is correct and we
can review it from there.

thanks,

greg k-h

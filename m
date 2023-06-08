Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249FF72797D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 10:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjFHICp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 04:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjFHICV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 04:02:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA426BA;
        Thu,  8 Jun 2023 01:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB0F64A18;
        Thu,  8 Jun 2023 08:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93806C433D2;
        Thu,  8 Jun 2023 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686211324;
        bh=w/yEsbDtDa91jOEzAVgq9g0PLRkhhzQq16y3KaLpBrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVP6KCoG5oc8inkb4NKyWt+t5NttTYCKqeMdIOAZOMqtJX2J2btHt5A/G93O/bJoy
         u3LY1L0aty/AQQKpaLiP4hRaXiy2zojhA3cdfOWBafieEXRBYcpXdw/pKemWFTyzT9
         GY2PS1Rnm0B8Jt805yc9vy4mJHB5bLf+jn9SWNGM=
Date:   Thu, 8 Jun 2023 10:01:56 +0200
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
Message-ID: <2023060827-overlaid-displace-b3a1@gregkh>
References: <20230518092240.8023-1-zhuyinbo@loongson.cn>
 <2023051843-scruffy-gush-cdec@gregkh>
 <aeaebb8c-e077-4678-62df-d80baff16347@loongson.cn>
 <ad9bfa94-1372-4810-734e-0bbaace37553@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad9bfa94-1372-4810-734e-0bbaace37553@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 08, 2023 at 03:54:36PM +0800, zhuyinbo wrote:
> 
> Friendly ping ?

For what?  I thought a new series was going to be submitted, I don't
have anything in my queue to review for this at the moment.

thanks,

greg k-h

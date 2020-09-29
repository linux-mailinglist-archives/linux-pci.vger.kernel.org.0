Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8CA27C250
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI2KY0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2KY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 06:24:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6E5C061755;
        Tue, 29 Sep 2020 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yeLMMUsMGsasm5JA4LJOmrFx065UrEdGafed4l8QHM=; b=FZgbv/uU4FzA4j48eQs5gsw4Kz
        P1Fkxew3WOzhh9b9IZ1jEYMxYn+8kn/v3x1qWLX/C/z05ayZ/wSnUYekRq8lfl6A0fED13985exvQ
        Ggj8/DuIMyOlSEIwOLFKg+DOzbH5lum73oOn9CRwXXz1c9RBIrZkiMyF/d5OmvhlXDbYxZYidlq72
        RdyR7PBBpG7Yia+wf1MGUABSG1VJ4Ir3aJQIAhmadJh0EScTSu9wigKSOLzvArkqFWflILF0p9TvU
        NBNpd+QFDmyIv7GXJdoRQ/CT3Zegqon1EcxOEoMtnOIkniDFofzum8wDTK8zJ19kZBXf1AGzw5UEz
        ccblkrlQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNCnz-0002J7-Ps; Tue, 29 Sep 2020 10:24:19 +0000
Date:   Tue, 29 Sep 2020 11:24:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20200929102419.GB7784@infradead.org>
References: <20200929084425.24052-1-sherry.sun@nxp.com>
 <20200929084425.24052-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929084425.24052-3-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> diff --git a/include/uapi/linux/mic_common.h b/include/uapi/linux/mic_common.h
> index 504e523f702c..e680fe27af69 100644
> --- a/include/uapi/linux/mic_common.h
> +++ b/include/uapi/linux/mic_common.h
> @@ -56,8 +56,6 @@ struct mic_device_desc {
>   * @vdev_reset: Set to 1 by guest to indicate virtio device has been reset.
>   * @guest_ack: Set to 1 by guest to ack a command.
>   * @host_ack: Set to 1 by host to ack a command.
> - * @used_address_updated: Set to 1 by guest when the used address should be
> - * updated.
>   * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
>   * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
>   */
> @@ -67,7 +65,6 @@ struct mic_device_ctrl {
>  	__u8 vdev_reset;
>  	__u8 guest_ack;
>  	__u8 host_ack;
> -	__u8 used_address_updated;
>  	__s8 c2h_vdev_db;
>  	__s8 h2c_vdev_db;
>  } __attribute__ ((aligned(8)));

This is an ABI change.

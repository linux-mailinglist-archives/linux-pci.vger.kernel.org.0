Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E765A0A54
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 09:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiHYHeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 03:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHYHeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 03:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E1A2618;
        Thu, 25 Aug 2022 00:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7B661A5E;
        Thu, 25 Aug 2022 07:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F82C433D7;
        Thu, 25 Aug 2022 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661412843;
        bh=axugL1PnwsjK36BEwrge3Rb1zps3tluVnOEPQ4h7dJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfk9vnZTpBghZSOGo6gZGMaiiqaoteXixykg0tvqNtaHbkwLyunsup43EcVqlj8Mp
         xq3DtRTbmWcP0cOvOIq2PP6uqNKcA23DD5nLUBOsWBrZ/SDtmQDVa1MP+dlFOuhGc7
         0f64Gb9z1i36kzWy1kzYl8V/19m3IocTu9k8zu18=
Date:   Thu, 25 Aug 2022 09:34:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <Ywcl6HPZ4HYCc641@kroah.com>
References: <20220824232450.723179-1-ira.weiny@intel.com>
 <20220824232450.723179-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824232450.723179-2-ira.weiny@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 24, 2022 at 04:24:49PM -0700, ira.weiny@intel.com wrote:
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -409,6 +409,7 @@ struct pci_dev {
>  	 */
>  	unsigned int	irq;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
> +	struct resource config_resource;		 /* driver exclusive config ranges */

Naming is hard, but let's make this obvious what this resource is for as
your comment states.  How about:
	struct resource driver_exclusive_resource;

Other than that, looks better to me, thanks for the update.

greg k-h

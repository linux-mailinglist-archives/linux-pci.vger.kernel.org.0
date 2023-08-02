Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0712676D300
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbjHBPyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjHBPxw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A89272A
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 08:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3EDB619D7
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 15:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2221EC433C7;
        Wed,  2 Aug 2023 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991548;
        bh=Lh3fXJXqzrKLmGTtOEbU1xywH6lZiOQQJpCFx/d1gvk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uAOBGOUvwnounY7GbixgmnvoYyynqBjkp+oXEtxp4bzZFd+gOIgR5UgFqbfYcxNum
         byfVG5Vgavg15TBoyccVQ+054Tdbg4PgAcFdvGwKQcvZAKPQzrL9XTvGP5BlZf+M/u
         VyIMMzhY52i8NSyj6mWlsBfxLQEfgpvY+yLIpO1R9yQzWjgR+DQNBGEavethomzsya
         DDd3gHI0rdmOtjVxaJrd3lLBTmC0gOKDBnZS0lWYUXMyjbD41Zcb33ZKT/LHW7lJrN
         4cUmJD7mPuaZRsonc5tVjm/LnoALbHc+8w9xa3hR+BPBHwOrfz+IN7bkNV5hLzTLPY
         ZVhJvrvSwF8bQ==
Date:   Wed, 2 Aug 2023 10:52:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/5] PCI: add ArrowLake-S PCI ID for Intel HDAudio
 subsystem.
Message-ID: <20230802155226.GA59821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802150105.24604-2-pierre-louis.bossart@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 02, 2023 at 10:01:01AM -0500, Pierre-Louis Bossart wrote:
> Add part ID to common include file

Please drop period at end of subject and add one at the end of the
commit log.

Also mention the drivers that will use this new #define; looks like
hda_intel.c and ...

Well, actually, I only see that one use, which means we probably
shouldn't add this #define to pci_ids.h, per the comment at the top of
the file.  If there's only one use, use the hex ID in the driver (or
add a #define in the driver itself).

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 3066660cd39b..a6411aa4c331 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -3058,6 +3058,7 @@
>  #define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
>  #define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
>  #define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
> +#define PCI_DEVICE_ID_INTEL_HDA_ARL_S	0x7f50
>  #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
>  #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
>  #define PCI_DEVICE_ID_INTEL_HDA_POULSBO	0x811b
> -- 
> 2.39.2
> 

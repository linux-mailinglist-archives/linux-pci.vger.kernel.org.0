Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD64D52DA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiCJUIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 15:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbiCJUIw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 15:08:52 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2035B9A;
        Thu, 10 Mar 2022 12:07:48 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id o64so7110402oib.7;
        Thu, 10 Mar 2022 12:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vz8tFKxmMK/K/IEgYulejF1e3lH7mgWHllpVfc4Pwd4=;
        b=Nqi7/ZKfLqJPgazCWUe/sNoUAH35EZtiAf98bS1ow1HB54n0FpgHbt0nEqN4vPbrX1
         XUvybzupayNpfCjRUpWZ06ynfU+bS1k4yujzznsqD5DbxKhFRmC5V6b9MsKR9pcp5GpT
         tTDJYh3smnN7GqM+ORMzEGMF0/udz67djiXTUJF92+VUQ84LkxreiJFPiqYw8dxV5R7P
         wiEfPlOI+EqbIK+LjeqYtweKlaNJUPYLrD5yvexr2JIe+z8rr0sa+3TRbyMuj+MAerPP
         NWioaw4jZeC6KO9BSI518bseE3zRmtC/d0+nC6dlhjgtB9hhshWrXtj9Abtyf9jtjS+J
         7KBw==
X-Gm-Message-State: AOAM533fHXLkRD+qMk40HYA/IJVyRylFIkn6sg2qyK2ShJn0Rul1vBA1
        AfyGWV5b87aRkj9PubC0lQ==
X-Google-Smtp-Source: ABdhPJyoKLeEqeKvLf8H43uDaKscsL5krGhRuaCfCSe6SoYHVbVcFY6nGLlrBo610Fgc6AkCtaiUtw==
X-Received: by 2002:a54:438a:0:b0:2d9:a01a:4be2 with SMTP id u10-20020a54438a000000b002d9a01a4be2mr4377991oiv.265.1646942868226;
        Thu, 10 Mar 2022 12:07:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 60-20020a9d0642000000b005b22a82458csm2708232otn.55.2022.03.10.12.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:07:47 -0800 (PST)
Received: (nullmailer pid 1977171 invoked by uid 1000);
        Thu, 10 Mar 2022 20:07:46 -0000
Date:   Thu, 10 Mar 2022 14:07:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        yilun.xu@intel.com, maxz@xilinx.com, sonal.santan@xilinx.com,
        yliu@xilinx.com, michal.simek@xilinx.com, stefanos@xilinx.com,
        trix@redhat.com, mdf@kernel.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 RESEND 4/4] of: enhance overlay applying interface to
 specific target base node
Message-ID: <Yipakr7/nn3McDbd@robh.at.kernel.org>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-5-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220305052304.726050-5-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 09:23:04PM -0800, Lizhi Hou wrote:
> The self discovered device, e.g. PCIe device, may carry a device tree
> overlay to describe its downstream devices. In this case, the device node
> is created dynamically by device driver. And in the overlay it does not
> specify a fixed target path. Instead, a relative path to the device node
> is specified.
> Thus, a new parameter is added to overlay applying interface. This
> parameter is the pointer of target base node. Then the entire overlay
> target path is target base node path plus the relative path specified in
> the device tree overlay.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/mgmt/Makefile       |  1 +
>  drivers/fpga/xrt/mgmt/dt-test.dts    | 15 ++++++++++
>  drivers/fpga/xrt/mgmt/dt-test.h      | 15 ++++++++++
>  drivers/fpga/xrt/mgmt/xmgmt-drv.c    | 41 +++++++++++++++++++++++++++-
>  drivers/gpu/drm/rcar-du/rcar_du_of.c |  2 +-
>  drivers/of/overlay.c                 | 37 +++++++++++++++++--------
>  drivers/of/unittest.c                |  2 +-
>  include/linux/of.h                   |  2 +-

The DT changes should be a 2nd patch.

That's the least of all the problems with this series though.

Rob

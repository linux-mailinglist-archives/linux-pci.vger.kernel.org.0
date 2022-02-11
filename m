Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A054B20DC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 10:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiBKJA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 04:00:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiBKJA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 04:00:56 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED75101C;
        Fri, 11 Feb 2022 01:00:56 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y5so15103928pfe.4;
        Fri, 11 Feb 2022 01:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYfaiwKavc3e6ks5kgUb85H+DdokL0giIO6Sl6/ijvM=;
        b=YirJZ/OrUY1KZE/c6Pg4WKdA/DVfcwtcmgwJ5LeUBhEbafCWoTh9dRaxYHbAAlx5/C
         U2C+6mW0+lJAlHWtOg6Jfruy1phkB55fCjanV518XXMonO4Hm6ZSmv0a+hkiWX4Xf2l2
         F9WP7bUMgjY+zB++WmbReucO/ta2ZBOXgrg92r7OGhkWQy37UA+S//xb9jpWn5ZKj96y
         LnpuDVcC32NCF4RZ+6aqEftgT8/PJdiEZnC+VclBeG3Ei8dWYSEKoWoxv52Zf/WhHGnV
         07bulekwlPGroFxqE2alC/bi7t4P/vt0jqRGa474mzrGuPqiaFj5qHcTUhc6uew3QFCw
         KNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYfaiwKavc3e6ks5kgUb85H+DdokL0giIO6Sl6/ijvM=;
        b=FznR8y6UZVSbxSC6hZgX+RV+KY5J/mB0ynksU/IkStbBmXvKCSROHT5QXUJ0gHz2+C
         FhnlCIpzHYk8oGTGf5c/9dwF8ctWDbXg+PjfFbdfGTV/jHpiPeO7EV5fQIZofBJ73LuN
         XljtE3Ckfx2W4/5b1S9rYjuCvELk5C39yhldm6gMI9+xT0I+aJJq1m7CfVxys61ssUBL
         xkj0UyD7FXefPtTeEBm4cqWbHziX6WtIS0PUpFOxYmWNoNUEe7rL15inaHAOn2F8vlBA
         JGf9aIw+f/5Mj8J+HHCjyaafLwUrtEQ0I/FX1lvfYATDeMErzPP6GRJJutQD2QcVMgKB
         EhVg==
X-Gm-Message-State: AOAM530PxixwKSnuBIAKd79+zJc1X9bVRSe679SLRwXF9w5xD4uOR4zs
        5pQD/9FyHphy/GZdLypq/0kACiAh7s5oCbh3ChI=
X-Google-Smtp-Source: ABdhPJzcBNwwDsrsLQTMfyhXlsVQPJ2eITAU351K13T2qQrMZreubqDuNlWvqA9y1Wv+mW0Rsuhg0no4yZY/uUPEJeI=
X-Received: by 2002:a05:6a00:2310:: with SMTP id h16mr697184pfh.80.1644570055706;
 Fri, 11 Feb 2022 01:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20220210224329.2793-1-mario.limonciello@amd.com> <20220210224329.2793-9-mario.limonciello@amd.com>
In-Reply-To: <20220210224329.2793-9-mario.limonciello@amd.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 11 Feb 2022 11:00:39 +0200
Message-ID: <CA+CmpXtah8AeVehExk0+eagyP=DQOPEy18DW3t2rQ0ZjyMk-Rw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] platform/x86: amd-gmux: drop the use of `pci_is_thunderbolt_attached`
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Alexander.Deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 12:43 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Currently `pci_is_thunderbolt_attached` is used to indicate a device
> is connected externally.
>
> The PCI core now marks such devices as removable and downstream drivers
> can use this instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 04232fbc7d56..ffac15b9befd 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -596,7 +596,7 @@ static int gmux_resume(struct device *dev)
>
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -       return pci_is_thunderbolt_attached(to_pci_dev(dev));
> +       return dev_is_removable(dev);
>  }
>

Maybe it's only me, but isn't it a bit strange to keep this function named
`is_thunderbolt` while it's actually about being removable?

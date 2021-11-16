Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11A44535CE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhKPPcg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 10:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbhKPPcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 10:32:33 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CDC061570;
        Tue, 16 Nov 2021 07:29:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b15so89270412edd.7;
        Tue, 16 Nov 2021 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP/WD34N2xW31YEPPdTkLsFiPxD+BXuI6TQenMThUU0=;
        b=k+xen1al/ElL2mRGcFuvoH64vuRVEdtffXC7y7Xuty7GIb6UdowAG3+pBld0/ZUVrg
         xv+R/lqbr5t9zDJuZEhcgIPps2pV52Ec8vl12s5AH063hwaaR/oGUI6pMSBKBT0hw5av
         2t33juLbhmwOQdL4hSgch6yzxdBHVgcPRwpIVWocpQNlRxbIHPWu7wYAib71oYqgUpzO
         YLbLUX4PAlH9Ui5cvgLaTUAOpNL6y7sDdmshBalzpOT0H8T17KpK9mI5iZGOMXVZMvXi
         TweMrQ6GCkN1N4DZg6gm+6kIDZLVKtYzm/gOtsDzEhM8pFCsJPIhkgR/2knvx8e+AjL9
         /92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP/WD34N2xW31YEPPdTkLsFiPxD+BXuI6TQenMThUU0=;
        b=lcixeUHsNjiLD/U6NOQfFHHUNWmCOpnaksumVP2f6YM7VyTNqe5+JPfAbluIjJ18or
         X5BfJgA6Y8IDj4SwhHZC5PIRey0NL0Dx/7ciwPJK6kLQecxrnq84DTNDzzRSHI9d9XNX
         erPxVwfgyhF0aqZ1JAwv57kUH5eDpXI0t7x0BPAMr6oCXTmDnocO6njMeA/JPGSXdrFo
         4kGrjw8a5lyi8Ocrkg9onB+vAynipzCstcq5z745p9MQyyekkIZS04kQp8AbFlFbMmK3
         LVv9o5vpyNZiYsPegbYVCL+XiyMgTp5GX5c+HpjqPNF2oucXlpaF+kilVDx+slv4ScFm
         H8mA==
X-Gm-Message-State: AOAM533MuvxTf4NpHr7b/491911YGGlRatISQfyXanJfbgVOScavipIU
        +13aAmqcEdaWbKR6gbzkGN8vHbaj667V4fo8oDY=
X-Google-Smtp-Source: ABdhPJy24zGx0EGIId68pmO/RIPAS3eflKt4vSUATfPZpGYsYh0Rdqaj9fJhQCII6f7euP5QBoXcnk7JIozbX08ZjiM=
X-Received: by 2002:a50:fd16:: with SMTP id i22mr11299530eds.224.1637076575153;
 Tue, 16 Nov 2021 07:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20211116131247.508424-1-hdegoede@redhat.com>
In-Reply-To: <20211116131247.508424-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Nov 2021 17:28:54 +0200
Message-ID: <CAHp75Vfb6Apx4wwcK6m3wKuj5O0xq7g2tGhiOJTuZZA4hfmT1A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Make the pci_dev_present() stub a static inline
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 16, 2021 at 3:14 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Change the pci_dev_present() stub which is used when CONFIG_PCI is not set
> from a #define to a static inline stub.
>
> Thix should fix clang -Werror builds failing due to errors like this:
>
> drivers/platform/x86/thinkpad_acpi.c:4475:35:
>  error: unused variable 'fwbug_cards_ids' [-Werror,-Wunused-const-variable]
>
> Where fwbug_cards_ids is an array if pci_device_id-s passed to
> pci_dev_present() during a quirk check.
>
> Fixing this in include/linux/pci.h should ensure that the same issue is
> also fixed in any other drivers hitting the same -Werror issue.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: platform-driver-x86@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note the commit message says "should fix" because I could not actually
> be bothered to verify this. The whole notion of combining:
> 1. clang
> 2. -Werror
> 3. -Wunused-const-variable
> Is frankly a bit crazy, causing way too much noise and has already
> cost me too much time IMHO.
> ---
>  include/linux/pci.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..7d825637d7ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1775,7 +1775,10 @@ static inline struct pci_dev *pci_get_class(unsigned int class,
>                                             struct pci_dev *from)
>  { return NULL; }
>
> -#define pci_dev_present(ids)   (0)
> +
> +static inline int pci_dev_present(const struct pci_device_id *ids)
> +{ return 0; }
> +
>  #define no_pci_devices()       (1)
>  #define pci_dev_put(dev)       do { } while (0)
>
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko

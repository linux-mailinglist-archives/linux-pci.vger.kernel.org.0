Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04436449F50
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 01:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhKIANg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Nov 2021 19:13:36 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42930 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhKIANf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Nov 2021 19:13:35 -0500
Received: by mail-wr1-f54.google.com with SMTP id c4so29881146wrd.9;
        Mon, 08 Nov 2021 16:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZVPz7RE8j2SkZNiVARcZPJsD5NeLqgS5xDhGT2VjvE8=;
        b=Et97hYx7KsK2cSgvcsoHqrVsGke8XEFv7c9k9xJm9thTnxtxwNekgB3u5MKaAwdwH/
         HWWqoLZGCQ1Xoluo2qF6uYnFDwQKY0yzwtZtkFYfM5IXJ5I9juaQtp8detkqHNv5qcoT
         P8nF/dKxoCTUXWWpdzMHMA7Biiz/vkso0yDe9uMKZfXh21LEpnBnHM9Y4Z+iqtSyEQe9
         j/pw1FCZcTL6/9bSdfA+iG4zY1M5v8LNtuKVFnOFO/owaapoIW6uPn3lj1i2hLjs+pDB
         vR8SGVwv/7uSYPHVJjXhuAUFDAxtk8hNpVUHcl+tmxw3DoMr4BeXC18srzo9XyW18Np5
         T2qA==
X-Gm-Message-State: AOAM530fDoDeHk0SGtyF1efVjKjr5vMg9G3XFmvf/xBLDmEFnOtKyLAC
        4cWmYCHyWx6Z4GiRfrlmhKk=
X-Google-Smtp-Source: ABdhPJyDtVTOsf2hgIXK1UcXDkH1yPcg6ieLQb6in8srUrjNQwgbnF1zEqOZyb7+uzNv/sCyjjKqBQ==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr3776175wrq.311.1636416649789;
        Mon, 08 Nov 2021 16:10:49 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n4sm20961016wri.41.2021.11.08.16.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 16:10:49 -0800 (PST)
Date:   Tue, 9 Nov 2021 01:10:47 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        clemens@ladisch.de, jdelvare@suse.com, linux@roeck-us.net,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and
 (A0h-AFh) PCI IDs
Message-ID: <YYm8h1wDTAm7Rkf5@rocinante>
References: <163640820320.955062.9967043475152157959.stgit@bmoger-ubuntu>
 <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163640828133.955062.18349019796157170473.stgit@bmoger-ubuntu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> Add the new PCI Device IDs to support new generation of AMD 19h family of
> processors.

This commit message matches the spirit of past additions very well, as per:

  commit b3f79ae45904 ("x86/amd_nb: Add Family 19h PCI IDs")

Admittedly, it would be nice to know what platform and/or generations of
AMD family of CPUs this is for.  Unless this is somewhat confidential and
in which case it would be fair enough.

For the following PCI related changes:

[...]
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F3 0x14b0
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F3 0x167c
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703

Acked-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof

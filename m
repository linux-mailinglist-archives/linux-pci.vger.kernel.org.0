Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9B3D0E6C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhGULWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 07:22:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44879 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbhGULOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 07:14:50 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mdf3x-1lXO6H0XWz-00Ziaj; Wed, 21 Jul 2021 13:55:24 +0200
Received: by mail-wm1-f54.google.com with SMTP id o30-20020a05600c511eb029022e0571d1a0so822956wms.5;
        Wed, 21 Jul 2021 04:55:24 -0700 (PDT)
X-Gm-Message-State: AOAM530AfRa3HKIYg6SIUv1WxpIVMi1Gb3NOkqgcQsM3iV1xXvIpM3lo
        wIcLf7lAVplJ6udiUptfxnkEuTS0xauAxaKuCO0=
X-Google-Smtp-Source: ABdhPJy4EXJSa5RpG/qfjvUKgiDhoM7SKGMs58HDYjrIRZu7cl/bUvkfbFQyQOZ55tRAZchy6LkfVE1zaiNR+vTackk=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr36193035wmj.43.1626868523806;
 Wed, 21 Jul 2021 04:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626855713.git.mchehab+huawei@kernel.org> <8dbdde3eda0e5d22020f6a8bf153d7cfb775c980.1626862458.git.mchehab+huawei@kernel.org>
In-Reply-To: <8dbdde3eda0e5d22020f6a8bf153d7cfb775c980.1626862458.git.mchehab+huawei@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Jul 2021 13:55:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0fB48uES77a+z=OyyV9Rd4HbA4Q7gkVFCtPV5yispGYA@mail.gmail.com>
Message-ID: <CAK8P3a0fB48uES77a+z=OyyV9Rd4HbA4Q7gkVFCtPV5yispGYA@mail.gmail.com>
Subject: Re: [PATCH v7 11/10] PCI: kirin: Allow building it as a module
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Mauro Carvalho Chehab <mauro.chehab@huawei.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Henry Styles <hes@sifive.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Wesley Sheng <wesley.sheng@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:t49h9CVeedSZ7+fdL7z6u910E0XuctlxZSelhJbgB07hKUXCtvr
 9drUzE44+OjS/J+dEodL3FTDBeF91SjK3urcQblBk8hcfgjDmOjpNYXziKAJm/MmB0Ar/xZ
 fX8bBx2A7wmEWCNZ9Mw7Iesg+Et5VlQeT10XipHZ1pXT/TSX6fjpSszdTD72XWIRmLcimHQ
 JoSi0Q4cp93Aj1u7qU4NQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6uSZ28bHNyE=:GfICW98GumRzDvpk8xW4pZ
 d7jJL/3g4xmYF4nXra0F7tjcW/qJm+ApMubRsgFGrehBx1zu3Gur5u6cBEe0lD3TGSkTzJ0v0
 let9/OFo9wKegZijpnLPqgl0o9pJHJcsN0j5RyndmtP0NKkH8o971xv70ir+mLW++Nnb3sTOb
 2KugNKtQsxKGRB80a/knxr1HwODi3VVjQLewGn5N92j4CjsrQdpIiyAlAv9mC0jqBwvZoM04L
 rzcw7F352J5FlKqyPdKH9vUKTAs4EIdjt4U8gOAJ7cGJJU3u8gT0SGg/r+oUuwvUX33H6jmEO
 i5/eqQz1OR+2dkohRjgJO7P3L79DePdx0NUqRbCqCenjCxuimoYXRX8VSEUEw/SvVtwBzE15K
 iluxJvWy4cgumHTjZn/LZQ2sW33nLZ149bzAbOkohY6Dz6Z2PkuPtGF5PsSCPOxdNpqdQB0TJ
 p3x3pwkXDmQTw8TOXphe0RmY3WmEQRb0FmR/fAmhzMCl2QZ8uZFUYRgJ1jssqLY8bJOuVIwD1
 zNkvI0bQJfGYR3mbFAH++5wrWylHb6k3Ae1vq/0/AIuaIO9DZW0lsiBGVoYcCAMG8V1hfmVp+
 mBgWEStMHcl+GfNbkcdshQSwAdnipewp/faXC123zAV1WUP9a3au9NCHHCXlGVOltjefO2yK0
 FdP7PyUdsXK8XJUUMAe5ZYmAY/07gXC9ScYD/H5gWzv7oBn6+IppY8nALr0cklZ0JBmR4XAqC
 gC5FNFbJH4cScAuDD45b28vrbiu2Dlmn48ku/KbmgIxuhrc4bSMkmumx4SLwug3X0S2Tkf4GI
 nLhdBx+wlgQBQVN8kcStFBwvolexVP5sSzix0szc5Dl6UqCdBv8ypFUrF+LAha1bVU11n2u
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 12:15 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> There's nothing preventing this driver to be loaded as a
> module. So, change its config from bool to tristate.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

No objections from me, but I wonder if you would also consider making the
module removable. It's currently marked as 'builtin_platform_driver',
so you can load but not remove it. Rob has done some bug fixes that make
it possible to remove similar drivers, so it's probably not much work
here either.

     Arnd

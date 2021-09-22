Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947EE414D54
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 17:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhIVPtI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 11:49:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43775 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhIVPtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Sep 2021 11:49:08 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MvJwN-1mkSvg0FEX-00rGex; Wed, 22 Sep 2021 17:47:37 +0200
Received: by mail-wr1-f43.google.com with SMTP id q26so8173619wrc.7;
        Wed, 22 Sep 2021 08:47:36 -0700 (PDT)
X-Gm-Message-State: AOAM531bwveLPqAiWdlf6fuMmEfjud2cxzFZgP4gWkILVIl5csCZptg4
        I/Sylbh6ZD7J7jRn1Fg9/mOzW1ooC0vfpyE7epw=
X-Google-Smtp-Source: ABdhPJxB6TJlgu1o3FLWomlpGuf9FbFSkPg8W1963ZV6qmS8zbuKAuZX7xZ4UTGLotnbbpRUNol21y/AFJHlcpA0/ew=
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr300802wrz.428.1632325656698;
 Wed, 22 Sep 2021 08:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210922042041.16326-1-sergio.paracuellos@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Sep 2021 17:47:20 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
Message-ID: <CAK8P3a2WPOYS7ra_epyZ_bBBpPK8+AgEynK0pKOUZ6ajubcHew@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: of: Avoid pci_remap_iospace() when PCI_IOBASE not defined
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, gregkh <gregkh@linuxfoundation.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:D320V8nbizMexIsreqyaNEfawUV75M+EGuv3g1eNZa4qn4Gj/Rd
 9Uias6asfUC7z4DmcY1P9AjeFam/hr2dsrHABvW5U3IkO532fKQdBycJJ9VVIGvfvImoTe2
 u/Hhq+/m45WmRuIIEF4UqFOPulfmjO+gmWOkwS9My/BxlEiaCxNUMjmkGgCjqE7lPFeh2W9
 HFNOBAvUdfk3xAC609Bug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TaM9WpEECRc=:Uty0OEb+PzWhfhq2H/A64C
 RQaV6GEPSN2evGY0ZS+a+fPsF0AsSUChOgySw+QQjWpezAFS2qnAR4ihld8YI6VRGbT9gaEVC
 +D7gk230ZuBP9Co29k0iOIrUtuxWldQtfnfnO85s+PXZ4NrMERd6lskY3uv1854NWgzJNR9Ic
 ARwQaGhhWgea1pjImc/A2SS2CCZz5hRqslu1+wtRUL4O11ZdbIVzCIDU0a90FsUEBeV3nHtz0
 JgpHqGQCJcgmxAa5YTqqI3eAXfABnZam211/0bpkylh+4EznZ6CDYYNg5W8rGVGPYcRDN6uOI
 Adje7sn5yuuAxYT3RoiAFe6ZJ20aWH+OxiBUDL0JTvnxjQRBcm91fbQY7osUnL+NB9QFb+WY2
 ODdHNqg5gSxTnIHI3AFIBFtpiSl4ryzCfVnD3RGLkBcbfd1oqsGwkNqMwoTCyvM3B3BIJL6V0
 YTJKu/7EwDFWMcFwF4Pr/taPu3CHENWDOvnCy6gAv02qBibVgb2FH7BLqajvkDHWBgSWHbK8C
 an2JIFgprEAgVIKJlKX8Gxhqi7ufS75RSeeJX5st0OzLiBDR5Yqaqf06/lrSj8hP0Wzoo1tfV
 q6fIvQ55QnwhaU7HDAlg6kV2hMTjSMQyJe26Lsv29ISB6MuE9dcxiYFLCXts2ZuNfWm+5GWKb
 n27zAk/P5WU3S0XRF/fB6zXF4SC4CmuwxyG16vZAxWdNFvvqInKMBOC0MuKYAuQ5qdwudISgc
 M4LsbonUqsPPqNpe7Y5Uzha1zLsd+gII5rlvSExvHF2jGVoR9Wa6HVOV7UQa5XKUx8VIpMn5x
 GS+6H1L6ADEEbyIWbvTKnBe+Dq6A07JLyui7Gxt/zhHhAzy1fwLD4lioOssZKvyc6cftLunBE
 +TYGzQsEF17Xh2M66IZQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 6:23 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:

> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index d84381ce82b5..7d7aab1d1d64 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>
>                 switch (resource_type(res)) {
>                 case IORESOURCE_IO:
> +#ifdef PCI_IOBASE
>                         err = devm_pci_remap_iospace(dev, res, iobase);
>                         if (err) {
>                                 dev_warn(dev, "error %d: failed to map resource %pR\n",
>                                          err, res);
>                                 resource_list_destroy_entry(win);
>                         }
> +#endif
>                         break;

I wonder if we should have a different symbol controlling this than PCI_IOBASE,
because we are somewhat overloading the semantics here. There are a couple
of ways that I/O space can be handled

a) inb()/outb() are custom instructions, as on x86, PCI_IOBASE is not defined
b) there is no I/O space, as on s390, PCI_IOBASE is not defined
c) PCI_IOBASE points to a virtual address used for dynamic mapping of I/O
    space, as on ARM
d) PCI_IOBASE is NULL, and the port number corresponds to the virtual
   address (some older architectures)

I'm not completely sure where your platform fits in here, it sounds like you
address them using a machine specific physical address as the base in
inb() plus the port number as an offset, is that correct?

       Arnd

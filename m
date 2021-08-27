Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9861E3F94B5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 08:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243142AbhH0HAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhH0G75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 02:59:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A3C0613CF;
        Thu, 26 Aug 2021 23:59:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so4160984pjs.3;
        Thu, 26 Aug 2021 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rqn+GrCddwb17438Eb7/acjTBeKWly1ebyK4GCadnFc=;
        b=Ahob/aCaoxGGmBX3uT/2Oo+coR/T1tys8xgPUYlJZHQ+79x1W7tMhNYHihEb3g00Pw
         m+dgL0BLb9DG6XuqQrGIlpqK11vUr+Y2ytYHZ7LdTBFa1tFBJE3STgSjF41FypNGQroh
         EB33JFOQSvpQcvOA/KVG6FqtXl7O0+BT+q4qQg5vtIojCX29E2kJoRY1MRvb3ovAgDbp
         aFXAm0ssP0g7n3TLr2XOHHUaLQbsPjFKeMCjJaff6OnyliY0dDUUm9ACwqxN5BizOny5
         6o6R1k1p3THp4VGKPD1gPgbF9N5SJmHFccehHvyHptaqGZoYeq1bOsTJYfzYeYbXFcTi
         n8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rqn+GrCddwb17438Eb7/acjTBeKWly1ebyK4GCadnFc=;
        b=ToFay4Mj171KSgAatRKbwrZRLxjM1j14IwtUx4af3DJaHCEo7VueRmcCerm9u0R0h7
         zMCIJxbIoFyCGq1qzK4YABwtmkqF0PntLqY09nZRgYRD8RzB9A/X3p1GJhNsUc5RCKP6
         uWk1J5WaqRFqUQCCUG5PzoZaZKipTGQmvXcn9XX0C8/ZNhuZUMwB4Dhj4ACyr4ZYdx2e
         ymc/kiobx37ur98IjTzBoTdMD1xC6h9aVzW8ILceizEer8qFS6k9bbQK7p4aq2EPljxf
         kruW11Lf/cldZpSMD+3+2JxfkC+7+PxuoFUxevHwltYku8u/woi7+Z9YNDIecECvB1h+
         dTnw==
X-Gm-Message-State: AOAM532go+s8Liqomo/NuCHFO1Ipw7T2YHTQsQ4tMwZ/Rsm+vHZFNOeq
        +gL7u+jikXdELWQEo7dO/mZWzY4dfUMGg+NmOGw=
X-Google-Smtp-Source: ABdhPJzbMPfKsiNwRsmJ6wf35o+bM3Vsllxj/xaKs1Zg3gEKi2+LtrBilr6TwQqyx2Jk+YbMtx83ULLwDM5rxvcqh8o=
X-Received: by 2002:a17:902:bb81:b0:12d:a7ec:3d85 with SMTP id
 m1-20020a170902bb8100b0012da7ec3d85mr7349833pls.17.1630047548297; Thu, 26 Aug
 2021 23:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210624155526.2775863-1-tientzu@chromium.org> <20210624155526.2775863-11-tientzu@chromium.org>
In-Reply-To: <20210624155526.2775863-11-tientzu@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Aug 2021 09:58:32 +0300
Message-ID: <CAHp75VfVhVGFEQGeUKajrUKmkx_et_KakDDgroC2BrMMhd62yg@mail.gmail.com>
Subject: Re: [PATCH v15 10/12] swiotlb: Add restricted DMA pool initialization
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com, thomas.lendacky@amd.com,
        quic_qiancai@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 24, 2021 at 6:59 PM Claire Chang <tientzu@chromium.org> wrote:
>
> Add the initialization function to create restricted DMA pools from
> matching reserved-memory nodes.
>
> Regardless of swiotlb setting, the restricted DMA pool is preferred if
> available.
>
> The restricted DMA pools provide a basic level of protection against the
> DMA overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system
> needs to provide a way to lock down the memory access, e.g., MPU.





> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> +                                   struct device *dev)
> +{
> +       struct io_tlb_mem *mem =3D rmem->priv;
> +       unsigned long nslabs =3D rmem->size >> IO_TLB_SHIFT;
> +
> +       /*
> +        * Since multiple devices can share the same pool, the private da=
ta,
> +        * io_tlb_mem struct, will be initialized by the first device att=
ached
> +        * to it.
> +        */

> +       if (!mem) {

Can it be rather

if (mem)
  goto out_assign;

or so?

> +               mem =3D kzalloc(struct_size(mem, slots, nslabs), GFP_KERN=
EL);
> +               if (!mem)
> +                       return -ENOMEM;
> +
> +               set_memory_decrypted((unsigned long)phys_to_virt(rmem->ba=
se),
> +                                    rmem->size >> PAGE_SHIFT);

Below you are using a macro from pfn.h, but not here, I think it's PFN_DOWN=
().

> +               swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
> +               mem->force_bounce =3D true;
> +               mem->for_alloc =3D true;
> +
> +               rmem->priv =3D mem;
> +
> +               if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> +                       mem->debugfs =3D
> +                               debugfs_create_dir(rmem->name, debugfs_di=
r);
> +                       swiotlb_create_debugfs_files(mem);
> +               }
> +       }
> +
> +       dev->dma_io_tlb_mem =3D mem;
> +
> +       return 0;
> +}
> +
> +static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
> +                                       struct device *dev)
> +{
> +       dev->dma_io_tlb_mem =3D io_tlb_default_mem;
> +}
> +
> +static const struct reserved_mem_ops rmem_swiotlb_ops =3D {
> +       .device_init =3D rmem_swiotlb_device_init,
> +       .device_release =3D rmem_swiotlb_device_release,
> +};
> +
> +static int __init rmem_swiotlb_setup(struct reserved_mem *rmem)
> +{
> +       unsigned long node =3D rmem->fdt_node;
> +
> +       if (of_get_flat_dt_prop(node, "reusable", NULL) ||
> +           of_get_flat_dt_prop(node, "linux,cma-default", NULL) ||
> +           of_get_flat_dt_prop(node, "linux,dma-default", NULL) ||
> +           of_get_flat_dt_prop(node, "no-map", NULL))
> +               return -EINVAL;
> +
> +       if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> +               pr_err("Restricted DMA pool must be accessible within the=
 linear mapping.");
> +               return -EINVAL;
> +       }
> +
> +       rmem->ops =3D &rmem_swiotlb_ops;
> +       pr_info("Reserved memory: created restricted DMA pool at %pa, siz=
e %ld MiB\n",
> +               &rmem->base, (unsigned long)rmem->size / SZ_1M);

Oh l=C3=A0 l=C3=A0, besides explicit casting that I believe can be avoided,=
 %ld
!=3D unsigned long. Can you check the printk-formats.rst document?

> +       return 0;
> +}
> +
> +RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", rmem_swiotlb_setup);
>  #endif /* CONFIG_DMA_RESTRICTED_POOL */

--=20
With Best Regards,
Andy Shevchenko

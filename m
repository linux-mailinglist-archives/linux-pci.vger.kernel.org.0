Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAD739254
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jun 2023 00:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjFUWM7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFUWM5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 18:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E881992
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687385526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmN6vynnk346Zef3QsDpwSts1f6YVa3MgD/3b47GBZg=;
        b=Itm/b41tiRfigc8rJB01INsNHT1YDXmNRrMmRcVxpBPFoXElviQTaX22KcgTFvigMO1aWO
        SX2RNatp2hIiYrrWiGdWQj/BTsED3KiRv5YGxFH5TcqcSEBKiRYmihZGqPdDoDUAQ/JKdI
        7AuAm3M8TE+qOccohTHxzKMQ2nfM0c4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-YNw6tXhRM3qujS9rAgB6ag-1; Wed, 21 Jun 2023 18:12:04 -0400
X-MC-Unique: YNw6tXhRM3qujS9rAgB6ag-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62fe7c97262so150096d6.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Jun 2023 15:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385523; x=1689977523;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmN6vynnk346Zef3QsDpwSts1f6YVa3MgD/3b47GBZg=;
        b=FyxKkWt3TNab5KO+8q5po6xLs8ejxVB/AiBcPv7Q+VZ3cL0G4ROxiV+YPrQWeQYTlU
         QwBPOkNIoZJz0v2HHUIVlUA3fj5nkwxgzpzDj/LcLJMcZ+yJOqjUe63sxGmTFXcp3moN
         OPxfZ9q1bfqOwJnTchjpG/hKkgJd1Yus7LyKHBkwPCtWsZ5ignG+1UhErD3RQQOUNq29
         QFg+HWDOtr46qQO4PlKaK7Dxwqv2Y1a1KawPdeFg0/njpRL79cgGE+J9Isup2gAs/n1J
         i1OzNvWEHwlPt+5qq6AR5KkmSRCk/z7DCrsAfkvdxYPIqkpyj41n0BzapTclmnyiTjJD
         /n5g==
X-Gm-Message-State: AC+VfDw+XmiW2S/ZZzG/h0eB4iXS010iSR/ioSGVnc8CK91+QNzmoL0S
        Stop7buOgOuAihjyLF4Owsokvs8kSA+gtyd7F1sbkxIZcd9FJHyNxQnEhsxi6KmI82uTb6J7bXU
        IG6uQabWpTuBHztptT8wU
X-Received: by 2002:a05:6214:29e1:b0:62d:f04b:b51 with SMTP id jv1-20020a05621429e100b0062df04b0b51mr17438807qvb.29.1687385523570;
        Wed, 21 Jun 2023 15:12:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56B7bI2LZsiCjtiffrV5rEA606kXuKzqD7PkY8RBVrcj0Iu0zK+Ncvisj1nwNYM7qYublmuA==
X-Received: by 2002:a05:6214:29e1:b0:62d:f04b:b51 with SMTP id jv1-20020a05621429e100b0062df04b0b51mr17438789qvb.29.1687385523319;
        Wed, 21 Jun 2023 15:12:03 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id p6-20020a0cf546000000b00623819de804sm2982153qvm.127.2023.06.21.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:12:02 -0700 (PDT)
Message-ID: <0afadc69f99a36bc9d03ecf54ff25859dbc10e28.camel@redhat.com>
Subject: Re: [PATCH v6 0/8] PCI/VGA: introduce is_boot_device function
 callback to vga_client_register
From:   Lyude Paul <lyude@redhat.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Ville Syrjala <ville.syrjala@linux.intel.com>,
        Li Yi <liyi@loongson.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Abhishek Sahu <abhsahu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        kvm@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Date:   Wed, 21 Jun 2023 18:11:59 -0400
In-Reply-To: <20230612192550.197053-1-15330273260@189.cn>
References: <20230612192550.197053-1-15330273260@189.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For the nouveau bits:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Tue, 2023-06-13 at 03:25 +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
>=20
> The vga_is_firmware_default() function is arch-dependent, it's probably
> wrong if we simply remove the arch guard. As the VRAM BAR which contains
> firmware framebuffer may move, while the lfb_base and lfb_size members of
> the screen_info does not change accordingly. In short, it should take the
> re-allocation of the PCI BAR into consideration.
>=20
> With the observation that device drivers or video aperture helpers may
> have better knowledge about which PCI bar contains the firmware fb,
> which could avoid the need to iterate all of the PCI BARs. But as a PCI
> function at pci/vgaarb.c, vga_is_firmware_default() is not suitable to
> make such an optimization since it is loaded too early.
>=20
> There are PCI display controllers that don't have a dedicated VRAM bar,
> this function will lose its effectiveness in such a case. Luckily, the
> device driver can provide an accurate workaround.
>=20
> Therefore, this patch introduces a callback that allows the device driver
> to tell the VGAARB if the device is the default boot device. Also honor
> the comment: "Clients have two callback mechanisms they can use"
>=20
> Sui Jingfeng (8):
>   PCI/VGA: Use unsigned type for the io_state variable
>   PCI/VGA: Deal only with VGA class devices
>   PCI/VGA: Tidy up the code and comment format
>   PCI/VGA: Replace full MIT license text with SPDX identifier
>   video/aperture: Add a helper to detect if an aperture contains
>     firmware FB
>   PCI/VGA: Introduce is_boot_device function callback to
>     vga_client_register
>   drm/amdgpu: Implement the is_boot_device callback function
>   drm/radeon: Implement the is_boot_device callback function
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  12 +-
>  drivers/gpu/drm/drm_aperture.c             |  16 +++
>  drivers/gpu/drm/i915/display/intel_vga.c   |   3 +-
>  drivers/gpu/drm/nouveau/nouveau_vga.c      |   2 +-
>  drivers/gpu/drm/radeon/radeon_device.c     |  12 +-
>  drivers/pci/vgaarb.c                       | 153 +++++++++++++--------
>  drivers/vfio/pci/vfio_pci_core.c           |   2 +-
>  drivers/video/aperture.c                   |  29 ++++
>  include/drm/drm_aperture.h                 |   2 +
>  include/linux/aperture.h                   |   7 +
>  include/linux/vgaarb.h                     |  35 ++---
>  11 files changed, 184 insertions(+), 89 deletions(-)
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


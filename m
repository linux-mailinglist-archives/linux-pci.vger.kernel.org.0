Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C52673494
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 10:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjASJjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjASJjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 04:39:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDA36C55E;
        Thu, 19 Jan 2023 01:38:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jm10so1765478plb.13;
        Thu, 19 Jan 2023 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfBVelv4aEwBb1YzL1pBGhsM2qMsLGoSKaCTLvIA0+8=;
        b=gD7dQBEZntcLnhi3RB0+MltROhlLsf5/kauy3NlLvWIlHO4r+oXbj2VSr0s7alIWbJ
         ahCizbBH0629aGlsniSEGqgst8nnu5pOsHdVnjx4giV5VSPeiXvRfUNvabaRnGCkXciK
         e+nYdaGEdgamTMI93jakjkyz9/q5tn2o61CBWveHQg2VX5lagXmC+zFJ5pm6yzaGwf7v
         R4fUach8vU3WR8YRaL4+wL7xBNgVI3e81WbxDU5/KDwlAEiP1RMr6Ukp3xxRxTTVKMHb
         HPGJ4SODFhxwj9rkrOD1t7OmIf1mD1apjcC992ySJXg508UpkqW24dsjHmgFWJ0jO5eM
         Ecqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfBVelv4aEwBb1YzL1pBGhsM2qMsLGoSKaCTLvIA0+8=;
        b=guZ8oQL8ESj0c1Cq04Cr8TJ6/GZJoPDldxxnXgBCfHV5fATKgFRKtbRgFIWwtflZS9
         uFntH1o7ZeUGrVPPPFPF96EkNLIqACAghIXrozCSRWGNlitFPr8nC+i3UbjU16RjiSuy
         I3ppeTNuEsKaQPuJq7mZtsxoAJOW3Pw1h6IQlr3aS0teMIhG/3g8p5fvHIatbrji60o+
         veEMgVS34t0zpB5E3pwsza7fVd6X61IgbOuopBQjVmTBbAfeZFYW35vWNEQRXs73IJm4
         OKEijcOnsPLcCkU3xhK7jATjwWcGtcvFzugDM8bPoRc+D2dLs9BLmxX3B74vh0L7zBgl
         Pvkg==
X-Gm-Message-State: AFqh2krkLiCX4H8OliQN6ybMQW9X7KGHTwYuO9/ycjBSqYhuqYyhGBMc
        A5jr3AovHd4hMFKoDPBWQO8=
X-Google-Smtp-Source: AMrXdXs5XnufN19FRhDIUPqVcKaRcXpI/o3i6WXBhY2Ma29PsyPKg1QDVY4pRPpdqeTdsS2FHynAiw==
X-Received: by 2002:a17:902:7042:b0:189:7548:2096 with SMTP id h2-20020a170902704200b0018975482096mr9808913plt.45.1674121125970;
        Thu, 19 Jan 2023 01:38:45 -0800 (PST)
Received: from debian.me (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00189f2fdbdd0sm24604975plh.234.2023.01.19.01.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 01:38:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E4998105027; Thu, 19 Jan 2023 16:38:41 +0700 (WIB)
Date:   Thu, 19 Jan 2023 16:38:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org,
        lukas@wunner.de, kabel@kernel.org, mani@kernel.org,
        pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Subject: Re: [PATCH v1 12/12] Documentation: fpga: add description of fpgahp
 driver
Message-ID: <Y8kPoXnCNyB7AwUv@debian.me>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
 <20230119013602.607466-13-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qVl6dm7wN+8OEMm3"
Content-Disposition: inline
In-Reply-To: <20230119013602.607466-13-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--qVl6dm7wN+8OEMm3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 08:36:02PM -0500, Tianfei Zhang wrote:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +FPGA Hotplug Manager Driver
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Authors:
> +
> +- Tianfei Zhang <tianfei.zhang@intel.com>
> +
> +There are some board managements for PCIe-based FPGA card like burning t=
he entire
> +image, loading a new FPGA image or BMC firmware in FPGA deployment of da=
ta center
> +or cloud. For example, loading a new FPGA image, the driver needs to rem=
ove all of
> +PCI devices like PFs/VFs and as well as any other types of devices (plat=
form, etc.)
> +defined within the FPGA. After triggering the image load of the FPGA car=
d via BMC,
> +the driver reconfigures the PCI bus. The FPGA Hotplug Manager (fpgahp) d=
river manages
> +those devices and functions leveraging the PCI hotplug framework to deal=
 with the
> +reconfiguration of the PCI bus and removal/probe of PCI devices below th=
e FPGA card.
> +
> +This fpgahp driver adds 2 new callbacks to extend the hotplug mechanism =
to
> +allow selecting and loading a new FPGA image.
> +
> + - available_images: Optional: called to return the available images of =
a FPGA card.
> + - image_load: Optional: called to load a new image for a FPGA card.
> +
> +In general, the fpgahp driver provides some sysfs files::
> +
> +        /sys/bus/pci/slots/<X-X>/available_images
> +        /sys/bus/pci/slots/<X-X>/image_load

The doc reads a rather confused to me, so I have to make wording improv:

---- >8 ----
diff --git a/Documentation/fpga/fpgahp.rst b/Documentation/fpga/fpgahp.rst
index 3ec34bbffde10c..73f1b53de1cf85 100644
--- a/Documentation/fpga/fpgahp.rst
+++ b/Documentation/fpga/fpgahp.rst
@@ -8,22 +8,22 @@ Authors:
=20
 - Tianfei Zhang <tianfei.zhang@intel.com>
=20
-There are some board managements for PCIe-based FPGA card like burning the=
 entire
-image, loading a new FPGA image or BMC firmware in FPGA deployment of data=
 center
-or cloud. For example, loading a new FPGA image, the driver needs to remov=
e all of
-PCI devices like PFs/VFs and as well as any other types of devices (platfo=
rm, etc.)
-defined within the FPGA. After triggering the image load of the FPGA card =
via BMC,
-the driver reconfigures the PCI bus. The FPGA Hotplug Manager (fpgahp) dri=
ver manages
-those devices and functions leveraging the PCI hotplug framework to deal w=
ith the
-reconfiguration of the PCI bus and removal/probe of PCI devices below the =
FPGA card.
=20
-This fpgahp driver adds 2 new callbacks to extend the hotplug mechanism to
-allow selecting and loading a new FPGA image.
+The FPGA Hotplug Manager (fpgahp) manages PCIe-based FPGA card devices.
+The PCI bus reconfiguration and device probe for devices below the FPGA
+card are done by leveraging the PCI hotplug framework.
=20
- - available_images: Optional: called to return the available images of a =
FPGA card.
- - image_load: Optional: called to load a new image for a FPGA card.
+The driver can be helpful in device management tasks like burning the enti=
re
+image and loading a new FPGA image or BMC firmware in FPGA deployment of d=
ata
+center or cloud. For example, when loading the image, the driver needs to
+remove all of PCI devices like PFs/VFs and as well as any other types of
+devices (platform, etc.) defined within the FPGA. After triggering the ima=
ge
+load of the FPGA card via BMC, the driver reconfigures the appropriate PCI=
 bus.
=20
-In general, the fpgahp driver provides some sysfs files::
+The driver adds 2 new sysfs callbacks to extend the hotplug mechanism to
+allow selecting and loading a new FPGA image:
+
+ - ``/sys/bus/pci/slots/<X-X>/available_images``: list available images for
+   a FPGA card.
+ - ``/sys/bus/pci/slots/<X-X>/image_load``: load the image.
=20
-        /sys/bus/pci/slots/<X-X>/available_images
-        /sys/bus/pci/slots/<X-X>/image_load

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--qVl6dm7wN+8OEMm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8kPmwAKCRD2uYlJVVFO
o3lrAQCct9H3y0zT3VjVNdLXNHJtFvNc7pF6h6RyrlsIR6FxAQD+KDkAExbGLjkL
pruDqPa1E0ukAI5fDYmeWbWLP7kPaAw=
=Eigz
-----END PGP SIGNATURE-----

--qVl6dm7wN+8OEMm3--

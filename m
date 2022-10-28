Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F780610909
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 05:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiJ1Dva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 23:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiJ1Dv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 23:51:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9C923E3;
        Thu, 27 Oct 2022 20:51:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w189so3793764pfw.4;
        Thu, 27 Oct 2022 20:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WO1uKkcgLMMLZ0+S2JOYsDVK1Cu/A+8fZzw0NT0jzU=;
        b=JBTJJOviLY8HXhKj8SBDpr5UKeIAnl5rn1ASKm8KfjzpeZHviO9XqGM9+eQH3/VVc7
         zsLE9rER6eWyGCc1Sn8HBL+b8DAJ7H7ZwGPLSWvL5D9mI5yQTOtC32WcX1dY/LacGZBX
         ERbApSD0ITGKREknS5NgNcXxiegAI90h/A2xXyg8jVGXhOVv/KU+qooU7afyvjlCxFld
         qekmz+m3YgXMnrlBIpMAZgD/ffkb9R+0SInxOgxT+RSk52pgOiWWZRDB00hpPOl55ZgR
         S/B9Q6M+I3wCqdLYyJvJpNtfNi4ww9MCG6dIjKUl4k7VF/T7u2spvSw7VMeYqYQBmXFP
         ulHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WO1uKkcgLMMLZ0+S2JOYsDVK1Cu/A+8fZzw0NT0jzU=;
        b=8CvnCg2zlo9x0ewrarhWtZJnKmqoBuMdQYhm7FXGQCQYRTNdiohBc32EPJaW47fcqO
         5A/bSfn70+5l6KYSTRfBLEGtRoutVcLZhaVx8QV737jl/97xq0j/layYH15fWacEKqH9
         VaDvu58gLkiEOBtmIP9s3TdkD2mxpOzO1imP9UaHSlyazjpxwDYCll8CgyFBIyJldfaO
         AnSSLYbGwFqe10MVy0CV61O8AGbYo+iYDa0dGKVwCbSZRzjMyPFxNZjqoTMVaKVof3hl
         cVbowRd2rsteckc235xaGoCYQVw5jUvq9mm2OF4XBrVIfNbdjMAnKZFjhAqShC4ulKUf
         u+Ow==
X-Gm-Message-State: ACrzQf0NL/+RArBtMB+RX562/IFP/MEKsVm5DYrVO0V9T89/mgqK0avm
        AwCALKLaVR3YNJBEKKDsYbX6vfcMMOU=
X-Google-Smtp-Source: AMsMyM4EePF6W3tYo8RzNrq591yvyvDQK+nsPN/C92RAiHKRcAodatGxeRfgXfuBQgTsyUuhW0mNFw==
X-Received: by 2002:aa7:9533:0:b0:56c:8c22:6e45 with SMTP id c19-20020aa79533000000b0056c8c226e45mr7689392pfp.84.1666929086611;
        Thu, 27 Oct 2022 20:51:26 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id t9-20020a62d149000000b00561beff1e09sm1880320pfl.164.2022.10.27.20.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 20:51:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 709B310030A; Fri, 28 Oct 2022 10:51:23 +0700 (WIB)
Date:   Fri, 28 Oct 2022 10:51:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add vendor ID for Quectel and Cinterion
Message-ID: <Y1tRu3SFMrS3su56@debian.me>
References: <20221028023711.4196-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Xw69vIUQyybTeYV"
Content-Disposition: inline
In-Reply-To: <20221028023711.4196-1-slark_xiao@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9Xw69vIUQyybTeYV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:37:11AM +0800, Slark Xiao wrote:
> In MHI driver, there are some companies product still do not have their
>  own PCI vendor macro. So we add it here to make the code neat. Ref ID
>  could be found in link https://pcisig.com/membership/member-companies
>  and https://pciids.sourceforge.net/pci.ids . Thales use Cinterion as
> their IOT modem card's trademark. So you will find 0x1269 belongs to
> Thales. Actually, Cinterion belongs to Gemalto, and Gemalto belongs to
>  Thales.
>=20

The patch description is confusing me.

What about below instead?

```
Add missing vendor ID for Cinterion (which is 0x1269).
```

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  include/linux/pci_ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..9e2b6286f53f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1765,6 +1765,8 @@
>  #define PCI_VENDOR_ID_SATSAGEM		0x1267
>  #define PCI_DEVICE_ID_SATSAGEM_NICCY	0x1016
> =20
> +#define PCI_VENDOR_ID_CINTERION		0x1269	/* Celluar Modules*/
> +
>  #define PCI_VENDOR_ID_ENSONIQ		0x1274
>  #define PCI_DEVICE_ID_ENSONIQ_CT5880	0x5880
>  #define PCI_DEVICE_ID_ENSONIQ_ES1370	0x5000
> @@ -2585,6 +2587,8 @@
>  #define PCI_VENDOR_ID_TEKRAM		0x1de1
>  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> =20
> +#define PCI_VENDOR_ID_QUECTEL		0x1eac
> +

Why pourring in Quectel ID while this patch is about Cinterion?

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--9Xw69vIUQyybTeYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1tRuwAKCRD2uYlJVVFO
oxIyAP481XABRghCrwrABNCawateQXhp6C3NFLwLZVLO0YijPwEA1xqi1znSReqk
twlMFSAHZGqaRNpSnb1QKnMSbLCUqQM=
=0ghT
-----END PGP SIGNATURE-----

--9Xw69vIUQyybTeYV--

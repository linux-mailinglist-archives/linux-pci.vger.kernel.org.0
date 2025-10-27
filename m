Return-Path: <linux-pci+bounces-39459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFF7C107D8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6A5E351626
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 19:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDBB32E15B;
	Mon, 27 Oct 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwU1j2US"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EF32E152
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591847; cv=none; b=J47BDF8Vw9WKMfKjQEE5tGMZK0900ie+u2Y5gkr6ecyS/QQuRXRRkqDqa0K6P2fqbaVUPVtmF359mrsZCElG/5AAVf17OOnKbu2FBE3/XiofMLbVFUur2Ip+dGXofmzwRXnx84PDAJjq47N4X37lRRpAiagUVvcotQ8rsD3HzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591847; c=relaxed/simple;
	bh=fcQeAhNiYJjtpEZq9ve4tm5KFCfMUDGuTGx0PXAYero=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF9SiXIqSb5dMrertECGA9L6gOXUTW7HhgG65EM1spOCiSn9P/U9UMDIE0L6aKQIbB7+A1TTfFS2Qu4bEb6vzkrtXujAFozJpax9q00DCYOmms+bUHKh9ZFzxf2ebFOfCKm1yuR0pTvo5taWlrKQqye9Z5aZ9ioIFV6QO8EM4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwU1j2US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BCCC116D0
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761591847;
	bh=fcQeAhNiYJjtpEZq9ve4tm5KFCfMUDGuTGx0PXAYero=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qwU1j2US3C1tV2Pe/xobyXU/1XkPiyq3LXjnYZWLhx2JpSYLy66qGMJyi8P6VdK11
	 Q0tN7I7otUSRJLVfIYRZ0j3X0kvS+nBlzBAM65iI1lmZSPUBJrjL9uNHtf4SLirNK0
	 jaSPLuNgtyOlg2J++KJ2mZkIhesG4CT60Fh/JcQGl+LiPOoV7YULdHP2r+yOh25+if
	 TVxo9gxEZ5FLONSpVPmOXArHQUxekkP7JzW7XL1Hf8bYFBd3CDbq6DjLIEJIc3aIsY
	 /oe2D0IfXhqcvpzYADRbaO682DbWQmlz2Z/6OfpICOtYR9KXt+IIY1Jrj/9pMNGkf8
	 mwR0sJaPxK/bg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-654ecc2af9aso1613814eaf.3
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 12:04:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfQzyyZ28Qyf0+S/ZxylA0ZPetYHFn4J/tw/xbhNn6OjAh3wYtc+ukAEoFlQC/zjTp2SUDV1Pd/9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzUe9mNts/4ft3SWp9r+8eyFtq452Q1yVyCL/GZQUovew9Drl
	0tb5Yn9VnvMrk509908h9aIezerMZdwe5vXcv+tcAjc4CXjuxtGJCgkNgSSzkyvyN6kQcGCBTid
	kaJRdjGscwwVaPL3uZvLqAG1yXJd1k7Y=
X-Google-Smtp-Source: AGHT+IHqU1lALKNbqY3/sWJ3Ed38JfJTEibmu5AJ+RAb0lY9VIMD5+XIUrwig44AUg2mO1SXH7aO4213auJAyyGLifY=
X-Received: by 2002:a05:6820:2288:b0:654:fab9:e7b1 with SMTP id
 006d021491bc7-6566effb7e3mr486841eaf.0.1761591846643; Mon, 27 Oct 2025
 12:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015080710.1468409-1-badal.nilawar@intel.com> <20251015080710.1468409-2-badal.nilawar@intel.com>
In-Reply-To: <20251015080710.1468409-2-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:03:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipDwzRUcAjs0r_3sTC1Noqt8VEMCUe6+bjgdR9C9Caeg@mail.gmail.com>
X-Gm-Features: AWmQ_bl3jHwN0OKod7003QqdzqRmx1Tkd8QlLOrctgpY1cHuLToGOg2ptxV1-iw
Message-ID: <CAJZ5v0ipDwzRUcAjs0r_3sTC1Noqt8VEMCUe6+bjgdR9C9Caeg@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com, karthik.poosa@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:02=E2=80=AFAM Badal Nilawar <badal.nilawar@intel=
.com> wrote:
>
> From: Anshuman Gupta <anshuman.gupta@intel.com>
>
> Implement _DSM method 0Ah, as per PCI Firmware r3.3, sec 4.6.10,
> to request auxiliary power required by the device when in D3cold state.
>
> Note that this implementation assumes only a single device below the
> Downstream Port will request for Aux Power Limit under a given
> Root Port/Downstream Port because it does not track and aggregate
> requests from all child devices below the Downstream Port as required
> by PCI Firmware r3.3, sec 4.6.10.
>
> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2(Bjorn/Rafael):
>   - Call acpi_dsm_check() to find method 0Ah supported
>   - Return retry interval to caller
> V3(Kuppuswamy)
>   - Add NULL check for retry interval
> V4
>   - Define enums for aux power request status (Rafael)
>   - Add Co-developed-by and clean up Signed-off-by (Kappuswamy)
>  (Bjorn)
>   - Instead of root pci device pass the pci device of driver, traverse
>     up the tree and discover _DSM
>   - Allow only function 0 of device to request aux power
>   - Allow retry_interval to be NULL
>   - Refine commit message and function description
> ---
>  drivers/pci/pci-acpi.c   | 114 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |   9 ++++
>  2 files changed, 123 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 9369377725fa..c7eab1e75dd5 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1418,6 +1418,120 @@ static void pci_acpi_optimize_delay(struct pci_de=
v *pdev,
>         ACPI_FREE(obj);
>  }
>
> +static struct pci_dev *pci_acpi_check_dsm(struct pci_dev *dev, u64 rev, =
u64 funcs)

The name of the function should be more specific than this, at least
to indicate that it is about the downstream port _DSM.

> +{
> +       struct pci_dev *bdev;
> +       acpi_handle handle;
> +
> +       if (!dev)
> +               return ERR_PTR(-EINVAL);

dev has been checked against NULL already by the caller.

> +
> +       bdev =3D  dev;
> +       while (bdev) {

And there would be fewer code lines if a for () loop were used here.

> +               handle =3D ACPI_HANDLE(&bdev->dev);
> +               if (handle && acpi_check_dsm(handle, &pci_acpi_dsm_guid, =
rev, 1 << funcs))
> +                       return bdev;
> +
> +               bdev =3D pci_upstream_bridge(bdev);
> +       }
> +
> +       return ERR_PTR(-ENODEV);

Personally, I don't see much value in putting this code into a
separate function.

> +}
> +
> +enum aux_pwr_req_status {
> +       AUX_PWR_REQ_DENIED               =3D 0x0,
> +       AUX_PWR_REQ_GRANTED              =3D 0x1,
> +       AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL  =3D 0x2,
> +       AUX_PWR_REQ_RETRY_INTERVAL_MIN   =3D 0x11,
> +       AUX_PWR_REQ_RETRY_INTERVAL_MAX   =3D 0x1F
> +};
> +
> +/**
> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is=
 in D3cold
> + * @dev: PCI device instance
> + * @requested_mw: Requested auxiliary power in milliwatts
> + * @retry_interval: Retry interval returned by platform to retry auxilia=
ry
> + *                  power request
> + *
> + * Request auxilary power to platform firmware, via Root Port/Switch Dow=
nstream
> + * Port ACPI _DSM Function 0Ah, needed for the PCI device when it is in =
D3cold.
> + * Evaluate the _DSM and handle the response accordingly.
> + *
> + * For Multi-Function Devices, driver for Function 0 is required to repo=
rt an
> + * aggregate power requirement covering all functions contained within t=
he
> + * device.
> + *
> + * Note: Aggregation across multiple child devices beneath the Root/Swit=
ch Downstream
> + * Port is not supported.

"Note: " isn't particularly useful here IMV.

> + *
> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested=
_mw,
> +                                     u32 *retry_interval)
> +{
> +       union acpi_object in_obj =3D {
> +               .integer.type =3D ACPI_TYPE_INTEGER,
> +               .integer.value =3D requested_mw,
> +       };
> +
> +       union acpi_object *out_obj;
> +       int result, ret =3D -EINVAL;
> +       struct pci_dev *bdev;
> +
> +       if (!dev || PCI_FUNC(dev->devfn) !=3D 0)

I'm not sure about the PCI_FUNC(dev->devfn) check.

Synchronization between drivers in this respect can be somewhat
tricky.  It would be more straightforward to allow the first caller of
this for a given port with the _DSM under it to "win" in all cases,
including different functions within the same device (this happens in
the other cases anyway IIUC).

> +               return -EINVAL;
> +
> +       bdev =3D pci_acpi_check_dsm(dev, 4, 1 << DSM_PCI_D3COLD_AUX_POWER=
_LIMIT);
> +
> +       if (IS_ERR(bdev))
> +               return PTR_ERR(bdev);
> +
> +       out_obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
> +                                         &pci_acpi_dsm_guid, 4,
> +                                         DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> +                                         &in_obj, ACPI_TYPE_INTEGER);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       result =3D out_obj->integer.value;

out_obj can be freed here and the code below can be made to return an
error code right away in multiple places.

> +       if (retry_interval)
> +               *retry_interval =3D 0;
> +
> +       switch (result) {
> +       case AUX_PWR_REQ_DENIED:
> +               pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
> +                       requested_mw);
> +               break;
> +       case AUX_PWR_REQ_GRANTED:
> +               pci_info(bdev, "D3cold Aux Power request granted: %u mW\n=
",
> +                        requested_mw);
> +               ret =3D 0;
> +               break;
> +       case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
> +               pci_info(bdev, "D3cold Aux Power: Main power won't be rem=
oved\n");
> +               ret =3D -EBUSY;
> +               break;
> +       default:
> +               if (result >=3D AUX_PWR_REQ_RETRY_INTERVAL_MIN &&
> +                   result <=3D AUX_PWR_REQ_RETRY_INTERVAL_MAX) {
> +                       pci_info(bdev, "D3cold Aux Power request needs re=
try interval: %u seconds\n",
> +                                result & 0xF);
> +                       if (retry_interval) {
> +                               *retry_interval =3D result & 0xF;
> +                               ret =3D -EAGAIN;
> +                       }
> +               } else {
> +                       pci_err(bdev, "D3cold Aux Power: Reserved or unsu=
pported response: 0x%x\n",
> +                               result);
> +               }
> +               break;
> +       }
> +
> +       ACPI_FREE(out_obj);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
> +


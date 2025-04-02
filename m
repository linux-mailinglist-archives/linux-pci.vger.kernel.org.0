Return-Path: <linux-pci+bounces-25153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000BA78CBD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 12:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEDC16E603
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48838236424;
	Wed,  2 Apr 2025 10:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTXo5pMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB12E3394;
	Wed,  2 Apr 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591559; cv=none; b=tqAMI5UyzrpK/TlwsJFSBDBQqYmeVEqp+Qzn1jli5BipA/LQUc7JlOqUK2zC6TxQk10M/9AeOfCN0vLLm1XEPONOc5h7cnurXOT37MBuiZg/9RVHa7h9yPt4KDKxOBYwDxQw2SE85XsR1xYB7y9rUI44UNInsh43JhN2zYBYOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591559; c=relaxed/simple;
	bh=79vlvCwhFQ7PQ167zysxT2YjCVKh2MWHR+DdDGPB3xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKXOEJWuGVT9eIttU/Yu/ybS+rhXdtc9Dpp29RCw3RMYvzh6SaG8oDPBsi+QbPzHSEtDQWQ+qVFnDy9n03G8U8NKM28eNkkG3uJiHCL+YXumP1b9T+yQBdZnnJeohD6DAwVK7MdQV+z3iJ7wd6a15BpSF36IV/5wk63l0dhC6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTXo5pMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB56C4CEED;
	Wed,  2 Apr 2025 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743591558;
	bh=79vlvCwhFQ7PQ167zysxT2YjCVKh2MWHR+DdDGPB3xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VTXo5pMATwS4NxbGZVkmTLXUmPqiDdvAl5J6oFqOEa0ItR+yMcZsPRkwg5ViPL508
	 VFtKW0iEiRGuqSSNTOFUZaSQtYum0rh4+esxr7aQbZMirdOjURMe2S/6wsEge/qjK/
	 MqfWnBIW5FlX480dhZv96IkYU6wsPHy+Fzr03LobSadb5z3GaDK3fYEOmcvtwR+Iar
	 2+UsW71kVXjr0ZimbbIYcGG8asPt4WWtbP3mIeo3MBU4OOUlEPRsWWcCUmofSYUlF9
	 P1yC2pFO2Ggid++9Y7NviGZxUrH4fvvxSW+0xpJV1/vn0wOkgyvX9b9e4a+YhJj9Uz
	 NNRCKKG2KuvuQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c81fffd523so2053077fac.0;
        Wed, 02 Apr 2025 03:59:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMuF8Ge+8YSfyOEocCJzzNUc0pbf0Q4VU0HzsF85XAOrqgxrpgEJergUye6HSmEWQyQFhXfw2lXg7P@vger.kernel.org, AJvYcCWUD/mm+/wUXFntR2v3d41uR/Lr66DgACtBXFBPJd8uLX6zwhUc1nAr/jJrGRqt3KhwpBTzG6Xk/3Kb@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUjKGVBkLlPc4RLRnbEQn+OKHue01FlRmKF2/hm6UUfrlfvWU
	tIB29khi3TE+XTOE8kmkRb7Yl+e9kWgNGOIBQhBlciawlEHfZKvp0jTa64HBjFogT12HUsqvaHQ
	sHgYgKwrD9QNHxJO3t6mCpBy7/sE=
X-Google-Smtp-Source: AGHT+IH6x+zQ+KQ+Tks6DI6Vj8fOJmmwES4mwbgUQGsKJyto/xGcDz/5bdLYfnSyTqx/izit30fZr0JSawhSg9xHppw=
X-Received: by 2002:a05:6870:9124:b0:2bc:7342:1a6c with SMTP id
 586e51a60fabf-2cc60b4f11cmr914246fac.19.1743591557770; Wed, 02 Apr 2025
 03:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401153225.96379-2-anshuman.gupta@intel.com> <20250401182545.GA1675819@bhelgaas>
In-Reply-To: <20250401182545.GA1675819@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Apr 2025 12:59:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hs9ddB1dGzGsMfaWrHdq1cw8huao63_m6pKRQq6BnEcw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq5BLkjL0lrW_VjmCt9KmP-6AC44giTO6xw8JDoD2ICihlpU3QmNicg3YQ
Message-ID: <CAJZ5v0hs9ddB1dGzGsMfaWrHdq1cw8huao63_m6pKRQq6BnEcw@mail.gmail.com>
Subject: Re: [PATCH 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Bjorn Helgaas <helgaas@kernel.org>, Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com, 
	rodrigo.vivi@intel.com, badal.nilawar@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 8:25=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Tue, Apr 01, 2025 at 09:02:14PM +0530, Anshuman Gupta wrote:
> > Implement _DSM method 10 and _DSM Method 11 as per PCI firmware specs
> > section 4.6.10 Rev 3.3.
>
> Thanks for splitting this into two patches.  But I think now this only
> implements function 10 (0x0a), so this sentence needs to be updated.
>
> I would write this consistently as "0x0a" or "0Ah" to match the spec
> description.  I don't think the spec ever uses "10".
>
> > Note that this implementation assumes only a single device below the
> > Downstream Port will request for Aux Power Limit under a given
> > Root Port because it does not track and aggregate requests
> > from all child devices below the Downstream Port as required
> > by Section 4.6.10 Rev 3.3.

Why is it regarded as compliant, then?

Request aggregation is a known problem that has been addressed for a
couple of times (at least) in the kernel.  Why is it too hard to
address it here?

> > One possible mitigation would be only allowing only first PCIe
> > Non-Bridge Endpoint Function 0 driver to call_DSM method 10.

What about topologies where there is a switch with multiple downstream
ports below the Root Port?

> >
> > Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> > Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> > Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> > ---
> >  drivers/pci/pci-acpi.c   | 78 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-acpi.h |  6 ++++
> >  2 files changed, 84 insertions(+)
> >
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index af370628e583..ebd49e43457e 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1421,6 +1421,84 @@ static void pci_acpi_optimize_delay(struct pci_d=
ev *pdev,
> >       ACPI_FREE(obj);
> >  }
> >
> > +/**
> > + * pci_acpi_request_d3cold_aux_power - Request D3cold aux power via AC=
PI DSM
> > + * @dev: PCI device instance
> > + * @requested_power: Requested auxiliary power in milliwatts

How's the caller supposed to find out what value to use here?

> > + *
> > + * This function sends a request to the host BIOS via ACPI _DSM Functi=
on 10
> > + * to grant the required D3Cold Auxiliary power for the specified PCI =
device.
> > + * It evaluates the _DSM (Device Specific Method) to request the Auxil=
iary
> > + * power and handles the response accordingly.
> > + *
> > + * This function shall be only called by 1st non-bridge Endpoint drive=
r
> > + * on Function 0. For a Multi-Function Device, the driver for Function=
 0 is
> > + * required to report an aggregate power requirement covering all
> > + * functions contained within the device.
> > + *
> > + * Return: Returns 0 on success and errno on failure.
>
> Write all this in imperative mood, e.g.,
>
>   Request auxiliary power while device is in D3cold ...
>
>   Return 0 on success ...
>
> > + */
> > +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 request=
ed_power)
> > +{
> > +     union acpi_object in_obj =3D {
> > +             .integer.type =3D ACPI_TYPE_INTEGER,
> > +             .integer.value =3D requested_power,
> > +     };
> > +
> > +     union acpi_object *out_obj;
> > +     acpi_handle handle;
> > +     int result, ret =3D -EINVAL;
> > +
> > +     if (!dev || !ACPI_HANDLE(&dev->dev))
> > +             return -EINVAL;
> > +
> > +     handle =3D ACPI_HANDLE(&dev->dev);

Well, ACPI_HANDLE() is not a simple macro, so I'd rather avoid using
it twice in a row for the same device.

What about

if (!dev)
        return -EINVAL;

handle =3D ACPI_HANDLE(&dev->dev);
if (!handle)
        return -EINVAL;

>
> This needs an acpi_check_dsm() call to find out whether the platform
> supports DSM_PCI_D3COLD_AUX_POWER_LIMIT.

Absolutely.

> We have several _DSM calls that *should* do this, but unfortunately
> they don't do it yet, so they're not good examples to copy.

Right.

> > +     out_obj =3D acpi_evaluate_dsm_typed(handle,
> > +                                       &pci_acpi_dsm_guid,
> > +                                       4,
> > +                                       DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> > +                                       &in_obj,
> > +                                       ACPI_TYPE_INTEGER);
> > +     if (!out_obj)
> > +             return -EINVAL;
> > +
> > +     result =3D out_obj->integer.value;
> > +
> > +     switch (result) {
> > +     case 0x0:
> > +             dev_dbg(&dev->dev, "D3cold Aux Power %umW request denied\=
n",
> > +                     requested_power);
>
> Use pci_dbg(dev), pci_info(dev), etc.
>
> > +             break;
> > +     case 0x1:
> > +             dev_info(&dev->dev, "D3cold Aux Power request granted: %u=
mW\n",
> > +                      requested_power);
> > +             ret =3D 0;
> > +             break;
> > +     case 0x2:
> > +             dev_info(&dev->dev, "D3cold Aux Power: Main power won't b=
e removed\n");
> > +             ret =3D -EBUSY;
> > +             break;
> > +     default:
> > +             if (result >=3D 0x11 && result <=3D 0x1F) {
> > +                     int retry_interval =3D result & 0xF;
> > +
> > +                     dev_warn(&dev->dev, "D3cold Aux Power request nee=
ds retry."
> > +                              "Interval: %d seconds.\n", retry_interva=
l);
> > +                     msleep(retry_interval * 1000);
>
> It doesn't seem right to me to do this sleep internally because it
> means this interface might take up to 15 seconds to return, and the
> caller has no idea what is happening during that time.

I entirely agree here.

If this is going to happen during system suspend, sleeping for seconds
is a total no-go.

> This seems like it should be done in the driver, which can decide
> *whether* it wants to sleep, and if it does sleep, it may give a nice
> indication to the user.

So during a system suspend in progress, this is rather hard to achieve.

I'd say that if the request is not granted right away, it is a failure
and we don't use D3cold.

> Of course, that would mean returning some kind of retry interval
> information to the caller.
>
> > +                     ret =3D -EAGAIN;
> > +             } else {
> > +                     dev_err(&dev->dev, "D3cold Aux Power: Reserved or=
 "
> > +                             "unsupported response: 0x%x.\n", result);
>
> Drop periods at end of messages.
>
> > +             }
> > +             break;
> > +     }
> > +
> > +     ACPI_FREE(out_obj);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);


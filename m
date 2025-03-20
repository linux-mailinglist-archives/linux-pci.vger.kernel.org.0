Return-Path: <linux-pci+bounces-24257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB9A6AEE2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6453BE993
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E0221579;
	Thu, 20 Mar 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRcnKJhs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A531EF378
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500449; cv=none; b=d5kt1j39451wTjarQsOQUqZmaV/uxdkJElKWX/mftFovDb60QaHeSZE4RxXp/cPR3bEuEvqIr++1IUFI1zmAZ6dvcTHyYfy3VHHeOQKfKRKn8k864w45CuuhRLYsZOSQnav7bMF4Dxi4oMIU19mWYqD7Vk8kE0GpgpodrijlRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500449; c=relaxed/simple;
	bh=GL058KUIaOeYZE8kWwRmItkewcqbuwQvo6P+XlYoHGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnfWi8lJAY/7H8YXgHnmJsGPq91sD9WjFPiyjpfa/jojogzRkxY3vi1w9Gtnbu2ZxYFS/5nwazOG1zPu2ZWAt+9qMApOwZ1v/GpcG23QGBnLsTpUevFOhL4bDpUtM1DbFjT9tGKPs8XMIc8IUrrnDFAU+untyTFW2Mbl1+fgDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRcnKJhs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so2118453a12.2
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742500445; x=1743105245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nF5Tdt8CRoEDhDjbwtVy58TyM0AOEfNbmhudgIUoyc=;
        b=QRcnKJhsXW6l33kjl0/Tf9XpOUyv5HcMNjjmnqY5/0yiCAcNrVyVG2vWPe3auuSWOa
         T+IUPh8UTPoXicJJbCBjklKeHPSAWxKk62yLF8jigYcNcqcM7EECxFtS3Lxu9rtBGZnd
         ttSSTw0MRhO26tFiOrGrUog+CJ/Ggf5SM9BJHVIX6rytJ1m4lBfyBD6XG2k0tIhu9LaK
         h+rY5QYyKvEU6xm0FvHnRkDyQDzVJ9efE48Gn/Qj0pyat3Syyn1JK8jxzzld7GGJ7paV
         C3216ctjaIck+2jcVCessvVVlZc5xM4Igoy6nSPIJpblFWjKZBfq4pPfaUqgaYqsedI7
         7tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500445; x=1743105245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nF5Tdt8CRoEDhDjbwtVy58TyM0AOEfNbmhudgIUoyc=;
        b=vuWklUF3PMh8pUp8h/7G9RbwnDmHgOhpsTYBY8OuV67dbx6ZQ91iwX6l9aiz4OJzym
         J3nLZm/B5YHFP+XrKZnBA9N37NMJ/IuCQVVHF+2rCPzy0rWve5Dfnf/D5C9y2w0+hsN3
         lCY1HPjBjn0CY9s913f4/0hU2wiZmo7BXFMo0fp0ayfAuAvFveyFN/YzBy6tBbRuulaz
         KKjHviBXAw2noIV3kXf9EZRRnLaNQAbFZnaJNR1D6unbqW5+AE5nMWy4PyCw938C/euT
         0ob/W/FGmsGIjo1HwoNdBHadfAIM0TEgz/OEH+kEpeo+fU0pbX/UjztqB9/xb/XHeAGW
         eooQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7gFFWioV0Ot4QKsjhLZMDPUJ51hPnOTpKqFPk0NshyV6NOUJOKTJ0uvJ4NSeCkMSldToxfKL1O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIWGBsYufKVraMRF7PvNbzkMolD5dPbgNc/3RVohAN97Y3Wwn
	hCDRY5765lkmYJvTT7yvhpsfKs3+nQkKYJAZwe+PnOlWMq8skbsRfWZtRSXrOZfqyl9DCFzuusJ
	Qkfza1zHj7iNV+oj+zxlTybtc7vEdhYZ6E1x8
X-Gm-Gg: ASbGnctAgWtt4sQP+Whesgtmdcbbv7VHxmG58LF9ED1ZWxFcaW3Y1DDMTkdahU0Vwid
	uq3p8clXxZQiFvhn6DZQPQP6tD9Pd1EfNs3Qga/M/Ne5Tct0Cq7YT3ZuMJ2jRMQqar2HyAmwytz
	oJrJFgoBrtb7GdUGTXgBRrqceFBaDrUj5XgzBWvTj8nBSC5anbh4hl0d++
X-Google-Smtp-Source: AGHT+IFWnjo0B4eLlbstS+r8jgMntSP+sOTIpKmcD/itkhK474N6r8hTkStsObYpCpDMQHSGENQEdKYqmb0ApJmNIcs=
X-Received: by 2002:a05:6402:51cd:b0:5e6:14ac:30f with SMTP id
 4fb4d7f45d1cf-5ebcd40a83fmr519012a12.2.1742500445219; Thu, 20 Mar 2025
 12:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ebafe3cc-2d0f-4000-863d-20365977e27c@oracle.com> <20250320175113.GA1089681@bhelgaas>
In-Reply-To: <20250320175113.GA1089681@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:53:53 -0700
X-Gm-Features: AQ5f1Jr4jSCRYI1pSAuF-CwNEX2UC9B0PUMlE--BhxT8R48qHGk0NnRnZk6iyj8
Message-ID: <CAMC_AXVi7cFOnSa25SEkZsYf27eoX1NwFmc8VnRgFQS44PpKRQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>, linux-pci@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Mar 20, 2025 at 03:56:53PM +0100, Karolina Stolarek wrote:
> > On 20/03/2025 09:20, Jon Pan-Doh wrote:
> > > +   /*
> > > +    * Ratelimits are doubled as a given error produces 2 logs (root =
port
> > > +    * and endpoint) that should be under same ratelimit.
> > > +    */
> > For these devices, we would call the ratelimit
> > just once. I don't have a nice an clean solution for this problem, I ju=
st
> > wanted to highlight that 1) we don't use the Root Port's ratelimit in
> > aer_print_port_info(), 2) we may use the bursts to either print port_in=
fo +
> > error message or just the message, in different combinations. I think w=
e
> > should reword this comment to highlight the fact that we don't check th=
e
> > ratelimit once per error, we could do it twice.

You're right. I was thinking of amending it to something like:

Ratelimits are doubled as a given error notification produces up to 2 logs
(1 at root port and 1 at source device) that should be under the same ratel=
imit.

> Very good point.  aer_print_rp_info() is always ratelimited based on
> the ERR_* Source Identification, but if Multiple ERR_* is set,
> aer_print_error() ratelimits based on whatever downstream device we
> found that had any error of the same class logged.
>
> That does seem like a problem.  I would propose that we always
> ratelimit using the device from Source Identification. I think that's
> available in aer_print_error(); we would just use info->id instead of
> "dev".

Wouldn't you be incorrectly counting the non-source ID devices then?
I think this is another reason where removing aer_print_port_info()[1] (onl=
y
printing port info when failing to get device error info) simplifies things=
. Of
course, we then have to weigh whether the loss of info is less than the
ratelimit complexity.

> > I'm also thinking -- we are ratelimiting the aer_print_port_info() and
> > aer_print_error(). What about the messages in dpc_process_error()? Shou=
ld we
> > check early if DPC was triggered because of an uncorrectable error, and=
 if
> > so, ratelimit that?
>
> Good question.  It does seem like the dpc_process_error() messages
> should be similarly ratelimited.  I think we currently only enable DPC
> for fatal errors, and the Downstream Port takes the link down, which
> resets the hierarchy below.  So (1) we probably won't see storms of
> fatal error messages, and (2) it looks like we might not print any
> error info from downstream devices, since they're not reachable while
> the link is down.

I did not expect error storms from DPC so I thought it best to focus on AER=
.

[1] https://lore.kernel.org/linux-pci/CAMC_AXWVOtKh2r4kX6c7jtJwQaEE4KEQsH=
=3DuoB1OhczJ=3D8K2VA@mail.gmail.com/

Thanks,
Jon





On Thu, Mar 20, 2025 at 10:51=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Thu, Mar 20, 2025 at 03:56:53PM +0100, Karolina Stolarek wrote:
> > On 20/03/2025 09:20, Jon Pan-Doh wrote:
> > > Spammy devices can flood kernel logs with AER errors and slow/stall
> > > execution. Add per-device ratelimits for AER correctable and
> > > uncorrectable errors that use the kernel defaults (10 per 5s).
>
> > > +   /*
> > > +    * Ratelimits are doubled as a given error produces 2 logs (root =
port
> > > +    * and endpoint) that should be under same ratelimit.
> > > +    */
> >
> > It took me a bit to understand what this comment is about.
> >
> > When we handle an error message, we first use the source's ratelimit to
> > decide if we want to print the port info, and then the actual error. In
> > theory, there could be more errors of the same class coming from other
> > devices within one message.
>
> I think this refers to the fact that when we get an AER interrupt from
> a Root Port, the RP has a single Requester ID logged in the Source
> Identification, but if Multiple ERR_* is set, find_device_iter() may
> collect error info from several devices?
>
> > For these devices, we would call the ratelimit
> > just once. I don't have a nice an clean solution for this problem, I ju=
st
> > wanted to highlight that 1) we don't use the Root Port's ratelimit in
> > aer_print_port_info(), 2) we may use the bursts to either print port_in=
fo +
> > error message or just the message, in different combinations. I think w=
e
> > should reword this comment to highlight the fact that we don't check th=
e
> > ratelimit once per error, we could do it twice.
>
> Very good point.  aer_print_rp_info() is always ratelimited based on
> the ERR_* Source Identification, but if Multiple ERR_* is set,
> aer_print_error() ratelimits based on whatever downstream device we
> found that had any error of the same class logged.
>
> E.g., if we had something like this topology:
>
>   00:1c.0 Root Port to [bus 01-04]
>   01:00.0 Switch Upstream Port to [bus 02-04]
>   02:00.0 Switch Downstream Port to [bus 03]
>   02:00.1 Switch Downstream Port to [bus 04]
>   03:00.0 NIC
>   04:00.0 NVMe
>
> where 03:00.0 and 04:00.0 both logged ERR_FATAL, and the Root Port
> received the 03:00.0 message first, 03:00.0 would be logged as the
> Source Identification, and Multiple ERR_FATAL Received should be set.
> The messages related to 00:1c.0 and 03:00.0 would be ratelimited based
> on 03:00.0, but aer_print_error() messages related to 04:00.0 would be
> ratelimited based on 04:00.0.
>
> That does seem like a problem.  I would propose that we always
> ratelimit using the device from Source Identification. I think that's
> available in aer_print_error(); we would just use info->id instead of
> "dev".
>
> That does mean we'd have to figure out the pci_dev corresponding to
> the Requester ID in info->id.  Maybe we could add an
> aer_err_info.src_dev pointer, and fill it in when find_device_iter()
> finds the right device?
>
> > Also, I wonder -- do only Endpoints generate error messages? From what =
I
> > understand, that some errors can be detected by intermediary devices.
>
> Yes, I think any device, including switches between a Root Port and
> Endpoint, can detect errors and generate error messages.
>
> I guess this means the "endpoint" variable in aer_print_port_info() is
> probably too specific.  IIUC the aer_print_port_info() "dev" parameter
> is always a Root Port since it came from aer_rpc.rpd.  Naming it "rp"
> would make this more obvious and free up "dev" for the source device.
> And "aer_print_port_info" itself could be more descriptive, e.g.,
> "aer_print_rp_info()", since *every* PCIe device has a Port.
>
> > I'm also thinking -- we are ratelimiting the aer_print_port_info() and
> > aer_print_error(). What about the messages in dpc_process_error()? Shou=
ld we
> > check early if DPC was triggered because of an uncorrectable error, and=
 if
> > so, ratelimit that?
>
> Good question.  It does seem like the dpc_process_error() messages
> should be similarly ratelimited.  I think we currently only enable DPC
> for fatal errors, and the Downstream Port takes the link down, which
> resets the hierarchy below.  So (1) we probably won't see storms of
> fatal error messages, and (2) it looks like we might not print any
> error info from downstream devices, since they're not reachable while
> the link is down.
>
> It does seem like we *should* try to print that info after the link
> comes back up, since the log registers are sticky and should survive
> the reset.  Maybe we do that already and I just missed it.
>
> This seems like something we could put off a little bit while we deal
> with the AER correctable error issue.
>
> Bjorn


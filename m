Return-Path: <linux-pci+bounces-11560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7651794D76C
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 21:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A29D1F22BE0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53A316D4E8;
	Fri,  9 Aug 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL7uYEYQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF316D4DA;
	Fri,  9 Aug 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232200; cv=none; b=gay9H1mWtBjreWWn0sKe1sJqi/bmfFKONJS1Bg32GTiE/H2ImBFRnW3iYBV8kMrncgtIlXmBn49KA5qT9TPAypBwnlzheIW9jqLzMVIDJCX+gd64DNk/nIYNcvs3V24ul1hfRwiDY9LidbjOjzYVwSh3Zv4LG49NeLPMbaxKaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232200; c=relaxed/simple;
	bh=mkPEFV98KvnOaAAN7g/wYK5Tu1zCY+dlV5z7gwpWU2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTemm6MF5uEU7E3wXwzfe14tuIa/SJnC7PeCSVVo/jAJo1eD7STjl+sxeeH4KQYetgIj6JiQEvZpOFNSErYbiXvc/9gv7cxScBjrS6wdFQvU1TMTsxbLvl9r/P5ZXlX6aeZnBk0TtPoGwkHTMGb/fxHoKK4Pz3yUiNOuQx5F9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL7uYEYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC19C4AF0F;
	Fri,  9 Aug 2024 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723232200;
	bh=mkPEFV98KvnOaAAN7g/wYK5Tu1zCY+dlV5z7gwpWU2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CL7uYEYQAr/juursVo6E/rVuKkgEgzuoszPNBzBAKJAI6fLASZ2N6PLbQon0a2JcN
	 C+5re9FhKI8DGNfI8noiYet6fLox5J/PnZoFeOCss7rkFqIak+1c2Mi6/tCmg0TNOR
	 3JcPglXTOZP3Er2zQib/SKVfTqWuHWXXT/gS6zMY2TYJTOG6J5lUQVmCQkRRTQdBWH
	 dkEaZipMeFFEz0zk0W7lPBXIcdxVX80hfPVzMovcm0kdX6XE4yboPsiDJc6n5OkIGN
	 /L7Ua83mB7Ux4Qgt0XGvrb156rP3/WCIo8fVs8JjNHuf1LGrdnyTIll0oIcQDOIgDb
	 ct6G8Du9dHIfQ==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66c7aeac627so24790977b3.1;
        Fri, 09 Aug 2024 12:36:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPvcHj0NYN/y+286SZBHxdVPdnSDh+cy8tjpbO6wQg+Jko8C5qhnbolyEQUvzGQWsT49P7shGXEtfQMzczvD6piUTKKo8hltwbIKT+ubwP7FEU6Bd+j+k70WUba6MSJmRsrhUTaQCDfkLw8kKpoIckYcIBaVhjzY616uWnO5IJz9x/UA==
X-Gm-Message-State: AOJu0YzqOqgVf03hVVNTrx6uxEQ980ty9DAech2qsm5yxzBaItsY6G6Q
	B/PyH8G++cYUss7C25vDDO1RhnguNvlmtQikSvvSIM1owZ0mzEBEjhsmjye1ZlWsw3Buy3Huj5M
	qt+57doxbNmp748lHcCLL9mzokg==
X-Google-Smtp-Source: AGHT+IHBGl9q4G8F8pliJY8Zk++lUNGSb02vw079AJRuY1yoNpvNqDe4xQYpgv06h2WkxHSBvtV3ggLblPSN7rtiP4s=
X-Received: by 2002:a05:6902:230d:b0:e0b:ab0b:6ec6 with SMTP id
 3f1490d57ef6-e0eb9946e2bmr2664155276.19.1723232199336; Fri, 09 Aug 2024
 12:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809151213.94533-1-matthew.gerlach@linux.intel.com>
 <20240809151213.94533-2-matthew.gerlach@linux.intel.com> <20240809181401.GA973841-robh@kernel.org>
 <98185d65-805f-f09d-789-6eda61c4b36d@linux.intel.com>
In-Reply-To: <98185d65-805f-f09d-789-6eda61c4b36d@linux.intel.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Aug 2024 13:36:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJg_ahW451sBht1k5SxP9s4dE09F-EWrgdXdDpUPFDfcQ@mail.gmail.com>
Message-ID: <CAL_JsqJg_ahW451sBht1k5SxP9s4dE09F-EWrgdXdDpUPFDfcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: PCI: altera: Convert to YAML
To: matthew.gerlach@linux.intel.com
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, 
	joyce.ooi@intel.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:43=E2=80=AFPM <matthew.gerlach@linux.intel.com> w=
rote:
> On Fri, 9 Aug 2024, Rob Herring wrote:
>
> > On Fri, Aug 09, 2024 at 10:12:07AM -0500, matthew.gerlach@linux.intel.c=
om wrote:
> >> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >>
> >> Convert the device tree bindings for the Altera Root Port PCIe control=
ler
> >> from text to YAML. Update the entries in the interrupt-map field to ha=
ve
> >> the correct number of address cells for the interrupt parent.
> >>
> >> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> >> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >> v8:
> >
> > v2 or v8 or ??? I'm confused and tools will be too.
>
> Sorry for the confusion. Patch 1 and patch 2 were individually reviewed
> previously. Patch 1 was previously reviewed up to v8, and I included them
> in the greater patch set for convience and completeness, and this is v2 o=
f
> the entire patch set.
>
> How should this be handled for better clarity? Would it be better to not
> to include Patch 1 and 2 in the patch set and refer to them, or would it
> better to remove the history in patch 1 and 2, or something else?

Generally, if you added new patches you keep the versioning and say
"vN: new patch" in the new patches.

If this was 2 prior series, combined, there's not really a good answer
other than don't do that.

Rob


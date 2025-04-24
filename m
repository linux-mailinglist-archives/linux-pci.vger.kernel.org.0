Return-Path: <linux-pci+bounces-26695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CDA9B1AE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E9B7AF880
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6274E19ABD4;
	Thu, 24 Apr 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSuoc2CC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C872701C1;
	Thu, 24 Apr 2025 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507272; cv=none; b=Kew2/rDFnE0u7GAZYhaU1n8VKnyysAsB1ZM88z9Z0qxxxOLP7JWTf/Vqc1UBapjZVcHTVv7GkKj9L7CDAxEIvoF0ot7fJiXCXeHrM59EHz4Jks6neLLbOHgOzvHRaVLz0SL5Wvj4hsDELOMh0eU3S1wDbZszbIjTwg9DaRBYAsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507272; c=relaxed/simple;
	bh=C2EZ1apAndk3/v0vmgQAhEZ5P5qimA9TdHfeO5X9suY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2tyh0kU2Ig09IqZ/wffaXO5U35OKHhPdqYHVdoPhRLsGO4igldtuZpwx1ZLESQz7BM9MM9iCO+s1sCwd08VuWc9Y+80LZvIOJcdKmqDsHQLBmGPSuhGsk34OHHwRGPh5v6h01aK1O5HMTVMrHAe7sGuQzN/4GLaxVLhgpSqTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSuoc2CC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9072C4CEEE;
	Thu, 24 Apr 2025 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745507271;
	bh=C2EZ1apAndk3/v0vmgQAhEZ5P5qimA9TdHfeO5X9suY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sSuoc2CCIv7YZ24pPXJFesLUJibGNO4r4KltBKGt4WicyIsIytf0Y29fvXDcEV1Ur
	 XrBICWdnMEPKqZiKHoWEOl2aWpbg3OsUrn76JIRXdAKrbuhImEzxL7O+S471CDtszy
	 /7kU4efIJN46IOk7M4SDaMwL8+YXOs/tdmb6yjOP6b1rOmXvsX7qJdiMWcFcu1EX4/
	 uUXR1tWRWr/0mf8emQhFYU7EIHlxbDoZhl/v1zRYBMM02vW+wkXWa0HKQcg6c4YoHe
	 vR/LyQO78DiGEPHMP9z40cMJ6CvsxUS9/Uq/P8fYiCe9bsbD8qNCW2yz4ARPwzH6II
	 5wnb/TGVgbU5g==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso4155382a12.1;
        Thu, 24 Apr 2025 08:07:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSxh4VKVRJIQWYiMhcrzczOzI4c6cz9WVkX9EDhp4XKBU8v8jQveplpTbeAQ1wtrLEyBHKGOKKhZoqtXbP@vger.kernel.org, AJvYcCWqbzeHAPXM2l+tRCnqdplHXCFtTh9eVjfGKHBkbsspfzX/FFNlmL/IIQEfdIbrDfjjMza+W90WDStl@vger.kernel.org, AJvYcCWyAXCU/ZztuPlkoUqm1Kiatzq62VOWLo07BAz+ZJbWrC6mAy18HJ/iXAwscpozb4d7HDor+ZszvnjQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jsLDMOmpnbL9GFO9Hx17bffDcRPIllxfj76zec+uc7X8COPI
	KAqBEpy9ssWYQri1IERxk2In3KBbqyJbfJZkFoNzvdUPONHd2UM94j/XcwoPd1SN2BsPVYy+JNC
	OxHEgHZCC9fLAWP3zlK9I+PrbHw==
X-Google-Smtp-Source: AGHT+IFhdMzyhzAig9c3GEzCIGFQQOuVXL3nlcgWG+8YQAheYOsb+jucq+ZoRkeYL8tN2ih3I3/l6YbuF0ROow8cHbw=
X-Received: by 2002:a05:6402:210d:b0:5e0:6332:9af0 with SMTP id
 4fb4d7f45d1cf-5f6ef1f8249mr2720700a12.14.1745507270130; Thu, 24 Apr 2025
 08:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com> <20250411202420.GA3793660-robh@kernel.org>
 <CH2PPF4D26F8E1C8ABE8B2902E5775F594FA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <CAL_JsqLNteS0m_32HuCjY8Mk9Wf+z6=HBpM7Wv=zLVqNs-7Y1Q@mail.gmail.com> <CH2PPF4D26F8E1C6C03FA2110C5AF9045F7A2852@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
In-Reply-To: <CH2PPF4D26F8E1C6C03FA2110C5AF9045F7A2852@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 Apr 2025 10:07:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgaeOcnUzw+rUF2yO4hQYCdZYssjxHzrDvvHGJimrASA@mail.gmail.com>
X-Gm-Features: ATxdqUG31eOi_waVP5NwjBplcNZWHhFFniBtiZHxRDCwGY3iPVWCvE4bH0E69wc
Message-ID: <CAL_JsqJgaeOcnUzw+rUF2yO4hQYCdZYssjxHzrDvvHGJimrASA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP controller
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "hans.zhang@cixtech.com" <hans.zhang@cixtech.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 10:54=E2=80=AFPM Manikandan Karunakaran Pillai
<mpillai@cadence.com> wrote:
>
> >> >What exactly is shared between these 2 implementations. Link handling=
,
> >> >config space accesses, address translation, and host init are all
> >> >different. What's left to share? MSIs (if not passed thru) and
> >> >interrupts? I think it's questionable that this be the same driver.
> >> >
> >> The address of both these have changed as the controller architecture =
has
> >> changed. In the event these driver have to be same driver, there will =
lot of
> >> sprinkled "if(is_hpa)" and that was already rejected in earlier versio=
n of
> >code.
> >
> >I'm saying they should *not* be the same driver because you don't
> >share hardly anything. Again, what is really common here?
>
> The architecture of the PCie controller is next generation but the softwa=
re flow
> and functions are almost same. The addresses of the registers accessed fo=
r the
> newly added functions have changed and to ensure that we reduce "if(is_hp=
a)"
> checks, the ops method was adopted as in other existing drivers.

Please listen when I say we do not want the ops method used in other
drivers. That's called a midlayer and is an anti-pattern. Here's some
background reading for you:

https://lwn.net/Articles/708891/
https://blog.ffwll.ch/2016/12/midlayers-once-more-with-feeling.html

So what are you supposed to do with the common parts? Make them a
library that each driver can call into as I already suggested. If you
want an example, see SDHCI drivers and library (sdhci.c). Actually,
the current Cadence support is also an example of this. It's 2
different drivers (pcie-cadence-plat.c and pci-j721e.c) with a library
of functions (pcie-cadence.c). We probably had this same discussion
when all that was upstreamed. Sigh.

Now, where there should be more ops is in struct pci_host_bridge for
things like link state and PERST# control. Then the PCI core could
manage the link state and drivers only have to provide
start/stop/status.

Rob


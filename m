Return-Path: <linux-pci+bounces-11324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E404F947F88
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 18:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACC3285625
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2024 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C272150269;
	Mon,  5 Aug 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaBykSQ1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974E13D8A8
	for <linux-pci@vger.kernel.org>; Mon,  5 Aug 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876327; cv=none; b=oOXy77QP/d8eIGsUnag0aYNJeJkY9trRBYOcYC9AHv03bGBRy38RfA+lOniodQmbRx8VjkeLFFgThNL2nnmeVUWSkp+zYSRgqwqAtHiTXw7nGMwkrvPKkEhseA8OzhrXhpTxq30ggY2lvXFwgpeTPPB6sJKSOhBIeiRr+w3+TRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876327; c=relaxed/simple;
	bh=J9dcjNEhuigihhB2QVhB/8KRB9/0LBlWcZmcLQPxlcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrFPpubn6EjgQcmukp4REtmfYbBx7MQJxNPbH7KYUrnA++bytpDvWneJRg/VOQMUssowuZq8/c2x84RxukdRbaRMEi5aW02gb13vCRiBVINHjNlCkJXzrYwMQ+ZhUYX3Y6Qiye5LXN/DiFy24n+26K0ZWvrHP849rcBOJMnBfLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NaBykSQ1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so9682001b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Aug 2024 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722876325; x=1723481125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=elZe0u4pf6+tTroIcQq16P0FNEAih6icH+aTFVnIbcQ=;
        b=NaBykSQ1BwqHts427WwjgLsgs3onEwusailDJpq+Pn8MsN/9pOK6ILjyg/3W04eXv/
         Fn99+xnkPdnQncwqYrcdRCJRxVZbpOZZoiLTvvxh44I+4Weq4ADO0o0zIXr595J/ZPGa
         WTiMV9o+Q7VWFFG4Ndsk/vvLnMgwDR1O8zf5qCxaS4qGDS/3ZdW/okJFbNOtVcDPM1Of
         mavl2piWAIRRNqW9dqHMLyI0PCgmyFx1zBi9FZIAJoGSmRNejPfcsK/KS8PkU51u4JSG
         ZTpQ9kJUmrXxI7K7rU/JYe+Cqan3sH+ErGNuQeqOmV5zo7uReyCVTY/w63uP4B2heYHN
         a97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876325; x=1723481125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elZe0u4pf6+tTroIcQq16P0FNEAih6icH+aTFVnIbcQ=;
        b=afK8r3GU4+LdAABKuG9QepEEBR6ijxOYttLTjMB8MC5eSkDnLOXuYU/F/q1MHNLWfk
         VtC+J8iCLbqdxyJ+CyFYjS8CQOjz7dPQVbJs/CyK8eGgQ0GlejcMGC1ecYCn+dE3WOCe
         2vKHZuIEHdssnDD0f3nWDGFTloNd1sAjuSeu07m1NOcwD1yPsQPq4XIgptFMnD6t0J+n
         bntSOqrV8VSTW/MdOJPB4vGY9DlLQiSUADszcsyfwfgBz9K4KCTQlbKKuDCisODLEOjJ
         X5ZSfBt19C0+SX3E7lKVHiFwVRVuRT4VdMeUGB2xPR3ug/QBSSx1z1/tiz3jOxpM6EKn
         kXTA==
X-Forwarded-Encrypted: i=1; AJvYcCWSzLCLi3kkz0vJuV2UkRiCPfeqLo58CGhDhyeap2fTenj0pq4om8hTG9Hh3YGt11T1JSJaNvH29qfHmsXAil2rnIGOWpw1XhAr
X-Gm-Message-State: AOJu0Yw74CICguFj62V+9Db+zhAJhMfqKWZC+TZ8k1X0JmmXzXsToJ5R
	rb1Dsss/LVWHXJmjpOp0nWnJ2fgKf8A8m9PfBvW989pgUE6oeDA6wuiHn5CzHw==
X-Google-Smtp-Source: AGHT+IFBLnmt9H3u40hP4Fu4vyHJiXZdRgS7RNWk1J+3zxffBfCXgzX+ENoa+40Slk8upRaJbYqxtA==
X-Received: by 2002:a05:6a00:928a:b0:70d:3420:9309 with SMTP id d2e1a72fcca58-7106cfd9664mr17583872b3a.17.1722876325286;
        Mon, 05 Aug 2024 09:45:25 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed31468sm5601810b3a.205.2024.08.05.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:24 -0700 (PDT)
Date: Mon, 5 Aug 2024 22:15:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, vigneshr@ti.com,
	kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org, ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <20240805164519.GF7274@thinkpad>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
 <20240724161916.GG3349@thinkpad>
 <20240725042001.GC2317@thinkpad>
 <93e864fb-cf52-4cc0-84a0-d689dd829afb@ti.com>
 <20240726115609.GF2628@thinkpad>
 <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ-mfU88E_Ri=BzH6nAFg405gkPPJTtjdp7UR2n96QMkw@mail.gmail.com>

On Mon, Aug 05, 2024 at 10:01:37AM -0600, Rob Herring wrote:
> On Fri, Jul 26, 2024 at 5:56 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Jul 25, 2024 at 01:50:16PM +0530, Siddharth Vadapalli wrote:
> > > On Thu, Jul 25, 2024 at 09:50:01AM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 24, 2024 at 09:49:21PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Wed, Jul 24, 2024 at 12:20:48PM +0530, Siddharth Vadapalli wrote:
> > > > > > Since the configuration of Legacy Interrupts (INTx) is not supported, set
> > > > > > the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
> > > > > >   of_irq_parse_pci: failed with rc=-22
> > > > > > due to the absence of Legacy Interrupts in the device-tree.
> > > > > >
> > > > >
> > > > > Do you really need to set 'swizzle_irq' to NULL? pci_assign_irq() will bail out
> > > > > if 'map_irq' is set to NULL.
> > > > >
> > > >
> > > > Hold on. The errono of of_irq_parse_pci() is not -ENOENT. So the INTx interrupts
> > > > are described in DT? Then why are they not supported?
> > >
> > > No, the INTx interrupts are not described in the DT. It is the pcieport
> > > driver that is attempting to setup INTx via "of_irq_parse_and_map_pci()"
> > > which is the .map_irq callback. The sequence of execution leading to the
> > > error is as follows:
> > >
> > > pcie_port_probe_service()
> > >   pci_device_probe()
> > >     pci_assign_irq()
> > >       hbrg->map_irq
> > >         of_pciof_irq_parse_and_map_pci()
> > >         of_irq_parse_pci()
> > >           of_irq_parse_raw()
> > >             rc = -EINVAL
> > >             ...
> > >             [DEBUG] OF: of_irq_parse_raw: ipar=/bus@100000/interrupt-controller@1800000, size=3
> > >             if (out_irq->args_count != intsize)
> > >               goto fail
> > >                 return rc
> > >
> > > The call to of_irq_parse_raw() results in the Interrupt-Parent for the
> > > PCIe node in the device-tree being found via of_irq_find_parent(). The
> > > Interrupt-Parent for the PCIe node for MSI happens to be GIC_ITS:
> > > msi-map = <0x0 &gic_its 0x0 0x10000>;
> > > and the parent of GIC_ITS is:
> > > gic500: interrupt-controller@1800000
> > > which has the following:
> > > #interrupt-cells = <3>;
> > >
> > > The "size=3" portion of the DEBUG print above corresponds to the
> > > #interrupt-cells property above. Now, "out_irq->args_count" is set to 1
> > > as __assumed__ by of_irq_parse_pci() and mentioned as a comment in that
> > > function:
> > >       /*
> > >        * Ok, we don't, time to have fun. Let's start by building up an
> > >        * interrupt spec.  we assume #interrupt-cells is 1, which is standard
> > >        * for PCI. If you do different, then don't use that routine.
> > >        */
> > >
> > > In of_irq_parse_pci(), since the PCIe-Port driver doesn't have a
> > > device-tree node, the following doesn't apply:
> > >   dn = pci_device_to_OF_node(pdev);
> > > and we skip to the __assumption__ above and proceed as explained in the
> > > execution sequence above.
> > >
> > > If the device-tree nodes for the INTx interrupts were present, the
> > > "ipar" sequence to find the interrupt parent would be skipped and we
> > > wouldn't end up with the -22 (-EINVAL) error code.
> > >
> > > I hope this clarifies the relation between the -22 error code and the
> > > missing device-tree nodes for INTx.
> > >
> >
> > Thanks for explaining the logic. Still I think the logic is flawed. Because the
> > parent (host bridge) doesn't have 'interrupt-map', which means INTx is not
> > supported. But parsing one level up to the GIC node and not returning -ENOENT
> > doesn't make sense to me.
> >
> > Rob, what is your opinion on this behavior?
> 
> Not sure I get the question. How should we handle/determine no INTx? I
> suppose that's either based on the platform (as this patch did) or by

Platform != driver. Here the driver is making the call, but the platform
capability should come from DT, no? I don't like the idea of disabling INTx in
the driver because, the driver may support multiple SoCs and these capability
may differ between them. So the driver will end up just hardcoding the info
which is already present in DT :/

Moreover, the issue I'm seeing is, even if the platform doesn't support INTx (as
described by DT in this case), of_irq_parse_pci() doesn't report correct
error/log. So of_irq_parse_pci() definitely needs a fixup.

> or by
> failing to parse the interrupts. The interrupt parsing code is pretty
> tricky as it has to deal with some ancient DTs, so I'm a little
> hesitant to rely on that failing. Certainly I wouldn't rely on a
> specific errno value. The downside to doing that is also if someone
> wants interrupts, but has an error in their DT, then all we can do is
> print 'INTx not supported' or something. So we couldn't fail probe as
> the common code wouldn't be able to distinguish. I suppose we could
> just check for 'interrupt-map' present in the host bridge node or not.

Yeah, as simple as that. But I don't know if that is globally applicable to
all platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


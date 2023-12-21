Return-Path: <linux-pci+bounces-1276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D485581C1AB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 00:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749D61F226B9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AB17946F;
	Thu, 21 Dec 2023 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhDe3UNV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EA79463;
	Thu, 21 Dec 2023 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-203fed05a31so840504fac.0;
        Thu, 21 Dec 2023 15:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703200554; x=1703805354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nre0qWYcjM9evMPmdd23Q9i0p6aQs6EJahQb/FB+V4=;
        b=WhDe3UNVuwHHn5UrXUeWAB14j0bLB9Um1cD4/gT8C+rQTbPvHdVxIYrQu2clsAERz5
         eOVODj04f2Cly7FAT7PESB+SVJChAwXV8d/POkL4gXtBa95D4gDBa3PMjlWgZcWNIADl
         CvhV5xhv/xn5A82oPgQ22+Abyg9GAScs0w10ZEwgHr4JyR1zYqcEXCIDFupciDMW5Joa
         fQXZCMtcIcrKt03uXrCg5mQkZdgYchnV55LTJgaOB1QNlmDNFAeF97ow7qUDlFowqpER
         kvtcYSTgN1MWtPzRWgutqjhoGSgFjFnh7hypQASCwuJhm6SA7rPkezJ4E+Lju8Zhx5ra
         S/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200554; x=1703805354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nre0qWYcjM9evMPmdd23Q9i0p6aQs6EJahQb/FB+V4=;
        b=Z6QT+q70a6YK443RhmZO3L89jFQVJ5da0ML6EntmBmcd0O9w76dM3ME7sWL5Ba1frS
         3Zn3Ldmok7iWeKZ8pciJ3Yk/nx+ouGCXM4UvcQgSrzncZAZ3J+uaDr4x4vAg1J4PFynD
         u33TMqdSfoiiSmTAoVqo8mH8sChqF+IcWAHVVrSaeHCR4ms/GCIKWZxtOG+8ek4TCJOR
         Z4NkLOaMQZe5iiptUWPOuucmFx8TWqxFSCcHngydcihPT6n6qALy81cR7qmtuTlUB+p/
         82HN8Wm13uvIIOyV/FL1rvJEgXj4G6QMYJt9hYQ/j/GqYf+m7M7FwH/8boLtnbUJA1Zc
         MmNg==
X-Gm-Message-State: AOJu0YwJHkl7gahmKOpDSyZQQYk0LKsLnMiSLtwrbMlnk6EBOf8BBRPv
	XSjDr1+12EUepWJrFGAR9V8=
X-Google-Smtp-Source: AGHT+IGZzNk23aiTKJG4kCFpEp37Rw4Mliz6BMEAibjlBre9d6rJO2P8sfQb2ikNSQsGZa2mNQ+BxA==
X-Received: by 2002:a05:6870:8091:b0:203:fbf6:8c36 with SMTP id q17-20020a056870809100b00203fbf68c36mr607260oab.68.1703200553693;
        Thu, 21 Dec 2023 15:15:53 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:80eb:fd4c:5e0a:7676])
        by smtp.gmail.com with ESMTPSA id z2-20020a62d102000000b006d9762f2725sm1739140pfg.45.2023.12.21.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 15:15:53 -0800 (PST)
Date: Thu, 21 Dec 2023 15:15:50 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZYTHJtn52MseDbr_@google.com>
References: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221-thunderbolt-pci-patch-4-v4-1-2e136e57c9bc@chromium.org>

On Thu, Dec 21, 2023 at 03:53:42PM -0500, Esther Shimanovich wrote:
> +static void carbon_X1_fixup_relabel_alpine_ridge(struct pci_dev *dev)
> +{
> +	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
> +	if (dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO)
> +		return;
> +
> +	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
> +	if (dev->subsystem_device != 0x22be && // Gen 8
> +	    dev->subsystem_device != 0x2292) { // Gen 7
> +		return;
> +	}
> +
> +	dev_set_removable(&dev->dev, DEVICE_FIXED);
> +
> +	/* Not all 0x15d3 components are external facing */
> +	if (dev->device == 0x15d3 &&
> +	    dev->devfn != 0x08 &&
> +	    dev->devfn != 0x20) {
> +		return;
> +	}
> +
> +	dev->external_facing = true;
> +}
> +
> +/*
> + * We also need to relabel the root port as a consequence of changing
> + * the JHL6540's PCIE hierarchy.
> + */
> +static void carbon_X1_fixup_rootport_not_removable(struct pci_dev *dev)
> +{
> +	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
> +	if (dev->subsystem_vendor != PCI_VENDOR_ID_LENOVO)
> +		return;
> +
> +	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
> +	if (dev->subsystem_device != 0x22be && // Gen 8
> +	    dev->subsystem_device != 0x2292) { // Gen 7
> +		return;
> +	}

This ventures into the realm of nitpicking, but this can be factored out
into a helper.

I'll shut up now and let PCI folks handle this.

Thanks.

-- 
Dmitry


Return-Path: <linux-pci+bounces-29390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E1AD499C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 05:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA55189CEF3
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACD420ADEE;
	Wed, 11 Jun 2025 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqEk1F2X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B1182B4;
	Wed, 11 Jun 2025 03:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613573; cv=none; b=OkCT6/PH4EF7P9b7VFbRyR6zZZz6FiFpx+7tQhaVEium2EqkQoO/+YjKSy8ZyK2P7PRqBrGl/XgVCa6DVUH/hvcxMumjjUaC/A1wY3SeduWSVzXGqIKtqbtkL4Tjs13wwKBLhRL6sqnAEzLrcN0S8Rtv3IqojyqGFmwbuJiI4QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613573; c=relaxed/simple;
	bh=SHCpUqf2sFrc2v6xjkUcGwxYgt9+plH2+LRllrC+TUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Urh8iCGIasLIt84dgjxQ8yWZCgbrbhrxUwP6BH1SopBdf7rGfkrS7v6ytvyRM/SCQ+gaIRj//R7xNbRQdnQQAz2yjaqX2SQEbS54Keg+5rbdM1V1Z0AyLls4JFfJi4IWIHEeYVFm3f8m753fczT4SWJ71VfyasYh3K7SEAPUlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UqEk1F2X; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e7971effd6so1015582137.1;
        Tue, 10 Jun 2025 20:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749613570; x=1750218370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg2tjw16mCCTcrpO92M+BgLFDyQbF8JC1z2OQxCbfIM=;
        b=UqEk1F2X2UoSCMVfXth9I4GGZ1VHcwPqryh9yiYfNB6QvvxpWaCLIDjbhNve2EmPro
         uU1wODfWhkOXNXDckvOplhYK1KJyCrZ2YYDXwOQ9FgAjv5tuILL89/1CFOriWnJVFHi/
         eLsip6dLgy+OwP0ht3m7i8S2E8VSuPlsyG/6/uA9Ea6JFO9j3SY8wn3fAxG4+cCHTRAe
         ZlNcPsOnf8Cf5EGjqMU9s3IfWx/IiNRNn1yWatmE+X/bU51GTmklv3AimiPf7+24NOla
         y9TbJWN464Z4syByhGWAL7MHzVwf7r2n5Zk/8tYgH9juNB034YRDWDjCS5wK/dlkckC7
         Pejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613570; x=1750218370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rg2tjw16mCCTcrpO92M+BgLFDyQbF8JC1z2OQxCbfIM=;
        b=xHR21gzsEcGOXg/Vg8Ygpjh0hZWP+JoWBPKGJPX6A8X7rR5yKooCwbHEGUUIPmj9rN
         Kp0Hgz/jLlzEaC8CWI/dxrNZ257j3A6YZyJLGw6tXGY0k7EHU5DpJBsyujy14TJsznPr
         ApRZ+bJ9GejntnzwvoZsUnfjSqqWhhOEzQG7H08kx6lbopNFkiWR5Jl19Ovw4vpoqsQf
         OvyjN87v58ZjTOOPEJz89Yx7/4KPIq/WdT0JLkkPa9CME4UJfzwhC1TnBtBrQaaV8I4D
         eV0woN7v90s4S/mlwU2S6w6ZKfqU3abrZkQg0kbhkV/CUc6swR4y++dSF0DN5vX2hjW5
         Ze0A==
X-Forwarded-Encrypted: i=1; AJvYcCVZsfpKFUsjkvz3DCJHq91Z26BdB/g9vJcnjbtfBhDEcCX4yp9gI4h0/gVj330nJAbmYGNwykx+8kAs@vger.kernel.org, AJvYcCW8iUe12STIxTHVH4KQClw6/dfFR9y+3CirYJ4u0Iwpx6oUfz7EHtuilRLQ3emVhJ/i7nbVbguxiK6xp9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaLB/IEMHSna9XZVkSprO9b+sQOwefkVcspbdZwuf09F5Ow/H
	Tq7s9eBOOPeAnCVIIvWm08Mv6bDpHCnFJq7QhTAKAl2eQ3xjO3BlsBQn
X-Gm-Gg: ASbGncsCvGdg9Tuzyh7WOmxMvZ6pyc3EWjsg3fBrUy0Hvik+euI7R665LZOL+Z9hs/y
	tU4lP9lmxUiO3BEn8/iR3uyIodlOVcEh2W9EFh+VCwGP8Huzw3/kVBeh2cgWAp/546zOdNSERDL
	9NHapb12PQ+HOfRUp4eqH87ipSf+Pbr8ZAnEtNgT2Yjl6wOWjxdoz/w9MTj3mkdNzORp9D/cwih
	MBJX52l8k1dDDE6UKYhUukbJ4WIvBn8ira96LdAH8B6f+BBRG9mcCtLJ78W084MZf4U+GVziPL2
	ajXCBqQWf0C6vcZk4LkUCsILFV5bNFpOWjiZnBQEdzIHOh0xlg==
X-Google-Smtp-Source: AGHT+IEjJ0BsROh1VIAfqNoWerdFkJh/8W2zLPk0S0XAU/Gcu0vW6QlsW9Odcrm98+pKp5HWoPp/zw==
X-Received: by 2002:a05:6102:f95:b0:4e7:3efd:ac76 with SMTP id ada2fe7eead31-4e7bba13384mr1443026137.8.1749613570087;
        Tue, 10 Jun 2025 20:46:10 -0700 (PDT)
Received: from geday ([2804:7f2:800b:5ecc::dead:c001])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae8551dsm2251922241.14.2025.06.10.20.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:46:09 -0700 (PDT)
Date: Wed, 11 Jun 2025 00:46:03 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] PCI: pcie-rockchip: add bits for Target Link
 Speed in LCS_2
Message-ID: <aEj7-6fMGKSXQb3J@geday>
References: <aEQb5kEOCJNQJMin@geday>
 <20250610200744.GA820589@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610200744.GA820589@bhelgaas>

On Tue, Jun 10, 2025 at 03:07:44PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 07, 2025 at 08:00:54AM -0300, Geraldo Nascimento wrote:
> This stuff:
> 
>   #define PCIE_RC_CONFIG_DCR              (PCIE_RC_CONFIG_BASE + 0xc4)
>   #define PCIE_RC_CONFIG_DCSR             (PCIE_RC_CONFIG_BASE + 0xc8)
>   #define PCIE_RC_CONFIG_LINK_CAP         (PCIE_RC_CONFIG_BASE + 0xcc)
>   #define PCIE_RC_CONFIG_LCS              (PCIE_RC_CONFIG_BASE + 0xd0)
>   #define PCIE_RC_CONFIG_LCS_2            (PCIE_RC_CONFIG_BASE + 0xf0)
> 
> *Looks* like it might be duplicates of:
> 
>   #define PCI_EXP_DEVCAP          0x04    /* Device capabilities */
>   #define PCI_EXP_DEVCTL          0x08    /* Device Control */
>   #define PCI_EXP_LNKCAP          0x0c    /* Link Capabilities */

Hi again Bjorn,

Your message reminded me of something that may be important.

During my debugging I had the mild impression L0s capability is not
being cleared from Link Capabilities Register in the presence of
"aspm-no-l0s" DT property.

I can't confirm it right now but I might revisit this later on. From
what I've seen it can only be cleared from inside the port init
in pcie-rockchip.c and does nothing in present form.

Not a clear, confirmable report but something to watch out for...

Regards,
Geraldo Nascimento


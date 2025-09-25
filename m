Return-Path: <linux-pci+bounces-37023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B35FBA157F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 22:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD98716B025
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 20:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780D258EC1;
	Thu, 25 Sep 2025 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JnKjtjil"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D318257858
	for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831718; cv=none; b=U27W3brfUjfEXGYePo5CtwaNINB5ZhZE8DeWxwd3ehoxO7NTh2FL9LZW8pWFRrn8yQ+LB+iGdxsvDwGKkOoK5u9P3QtyK12SoxwRcapKoYUo1Vsejq0UQsliTfoQ5KcQSniS0k2V1K/qcjVWc5oTtco7Y+KSYdvLSPFFupgXBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831718; c=relaxed/simple;
	bh=euzV77BdkfsGWFwwEk3uPho3BTbjX+RPOkSRRUB/Mcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzqLgOpT8jJyukrcMn3KrlFOJKYnhVj9225iyDlWDxm3VG9udxDUP2snCCz9apWjl8/5HoUA+biRXLBendkROmq+cRBDmWSc8mjVyWon95sZYAv31x7tXlPTUgrl9w8gKEU0RJ2pBmXwi8mkYJVUdssLQX8yKYHb+LfYozItU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JnKjtjil; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-30cce872d9cso1442933fac.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831715; x=1759436515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kg9EbUzc5UeCSnUDVlV70pveZSB7pxPb2WV83lF9tKE=;
        b=kfFD22gDGYeGxvJsuG9mm1sF9V2vVgTO49snTTFsE9/5ynVdXlVpQv0drwB0PwAGXm
         qpwdDfGNPVyx9gaBK5iQsvSuOMKmRPi6ja5WUnBnv1e7EIVU0G09Kd0k7AKaBwqnv4tk
         ZQ9NNgxH0IhK+KzyJN+a+mW/sOpZRd7YyY+kdv2Oy9B0qQyl9aoNnqclbjpfjQi5nUbT
         Csp8klnSoOnQRFAfeCjy6+0c5NXlzds5fi3rw/rFKgro7ur9ZBo2QTKISNhpMmi1Y8Fr
         Tx20FTn/V16GC6WNAZRYbtC9WPMarkaiR53PXjXCJ4Mw5ojTIIt6bjdxcb/fTPdk+uFs
         DMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWzG36EVxesWeqU2h7XIOQ3PZcEXoGEtuB8NBu1mH5Mk8WXzAYsRo6MO7T0npgipvPjI5tmYF8PsW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+2jQoN1T2kUGOxakEzJV1cxBZWm9wELvB9N+7Z5i3oybtNed
	S7JODwMgygUbbYS+h32g4Wh1IxQGokc2fg/PWvcrmwF58kdBqsKSntwxUgkErFmpxfEiojGbCvi
	khLGCnLz+0XN7zSTZhfUmeN2GAjjpTGFRZJ3xpQKnYO6umMBW4SeE4NSnoRcOY7JpWoqM5MezD+
	8h92m4IKNWH3KqJ2s5lc6KCZUMzG2uyyLw9b5MqQQ9agt3moigBEAV4D7txfQ3qn1RhYYzbaxzb
	sO2wshlxLHYy4LZ
X-Gm-Gg: ASbGncsDhsPd/4HT2zCtVTvJZlIuc9VC80wfV0MpraLgUgNGTWPWin9MnxjDzcrhtSv
	X5BW3ddkoYB0dpE349gVko28TeZEm9+hc+ermambj9FtMiIzFlSGwHqrF5BLw3gAGxTP59KFiwN
	AXdUbT95m4upBx8IiQSsmiflCOtikFCR4YKIvPmiK5hZS1Cvm1I4/ipcKaTWNrVfZM3ieRm9SER
	YWdXT6es2G32APootKUFUdwbmQF5KJX/8s6dRMNK5J9fbTqqRp2RKIB30HO0N0BVZ/yhgRtevG6
	XqegN/IbwtM1VdR/YCNNzy1RbyFtYYLzN01qRfLT89D6Xi1hLknqJYxyS+JA/S8sG8z7ykLvgiV
	nG29VzfJHHm7okoOUvfd0ZaBNuQvdciV7p38zl01pjSPZ8N9zLR84VuTvjo0XZZFK/rISp91li4
	Wa
X-Google-Smtp-Source: AGHT+IH2lGUcZf/UgngomhSHtqz/GRVkOw3F+NOrCaeLqRnA76sb9UElHh9QNI6hfUkeo5o41wgmdkrigZ/z
X-Received: by 2002:a05:6870:b6a0:b0:31d:8ceb:20f2 with SMTP id 586e51a60fabf-35eeaa480f0mr41308fac.41.1758831715587;
        Thu, 25 Sep 2025 13:21:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-363a5927ee8sm204021fac.9.2025.09.25.13.21.55
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Sep 2025 13:21:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-57a31c382b8so999109e87.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Sep 2025 13:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758831713; x=1759436513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg9EbUzc5UeCSnUDVlV70pveZSB7pxPb2WV83lF9tKE=;
        b=JnKjtjilBG0cpjC30KC7v4Q5hc4boXYgGB97ljMA3nbLAETgYzSyHlSeJN/b5p0yCF
         s8jmMHxmWxFFIjitBtAiTaXWXBmWNi7r9CW68TPQ6ggRTpLcbh/WU0Dr2V4PEYEYFrEo
         ryWBFjtzjUdzPeAhRMUHJbO9Zetwi244i8r2w=
X-Forwarded-Encrypted: i=1; AJvYcCVg06d1MZLEvfJsrW2xMfzucFnLLzSdIQYGGziFKHT6CW3EILH/RqSgqqI9C6jTBdFtzZtKa3aWk2U=@vger.kernel.org
X-Received: by 2002:a05:6512:3b9b:b0:579:f273:190 with SMTP id 2adb3069b0e04-582d2f27c3amr1518825e87.33.1758831713480;
        Thu, 25 Sep 2025 13:21:53 -0700 (PDT)
X-Received: by 2002:a05:6512:3b9b:b0:579:f273:190 with SMTP id
 2adb3069b0e04-582d2f27c3amr1518817e87.33.1758831713028; Thu, 25 Sep 2025
 13:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925194424.GA2197200@bhelgaas>
In-Reply-To: <20250925194424.GA2197200@bhelgaas>
From: Jim Quinlan <james.quinlan@broadcom.com>
Date: Thu, 25 Sep 2025 16:21:40 -0400
X-Gm-Features: AS18NWCle_VWcRQyBAHWhBM5ha7dc-YBCRc3SNPv5B0dK9GdkwygDuVW9TnwVpY
Message-ID: <CA+-6iNyZzS5HRB8sy4gnVpo_ksQ92bWp2SpKtODB+WQE1YB7Vw@mail.gmail.com>
Subject: Re: brcmstb PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK issue
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Quinlan <jim2101024@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Thu, Sep 25, 2025 at 3:44=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> I think caab002d5069 ("PCI: brcmstb: Disable L0s component of ASPM if
> requested") introduced a problem:
>
>   #define PCIE_LINK_STATE_L0S             (BIT(0) | BIT(1)) /* Upstr/dwns=
tr L0s */
>   #define PCIE_LINK_STATE_L1              BIT(2)  /* L1 state */
>
>   +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK   0xc00
>
>   +       /* Don't advertise L0s capability if 'aspm-no-l0s' */
>   +       aspm_support =3D PCIE_LINK_STATE_L1;
>   +       if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
>   +               aspm_support |=3D PCIE_LINK_STATE_L0S;
>   +       tmp =3D readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
>   +       u32p_replace_bits(&tmp, aspm_support,
>   +               PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
>
>
> PCIE_LINK_STATE_L0S is two bits, PCIE_LINK_STATE_L1 is one bit, and
> the u32p_replace_bits() tries to put all three bits into the two-bit
> PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK field.


Thanks for the catch.  It is a bug.  It did not have any effect until
some point after 5.15,
when PCIE_LINK_STATE_L1 went from BIT(1) to BIT(2).  Regardless, I
should have been ORing
PCI_EXP_LNKCAP_ASPM_{L1,,L0s} all along.

I'll submit a fix ASAP.

Thanks & regards,
Jim Quinlan
Broadcom STB/CM


>
> Interestingly, the compiler only warns about this when !CONFIG_OF
> because in that case the of_property_read_bool() stub always returns
> "false".  A Kconfig tweak is needed to build this with !CONFIG_OF.


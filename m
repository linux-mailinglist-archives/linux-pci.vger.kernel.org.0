Return-Path: <linux-pci+bounces-41282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D59C5FFCA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 05:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF13B058E
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 04:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC8225A35;
	Sat, 15 Nov 2025 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ipw5tVdT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mDufRdfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3212010EE
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763180517; cv=none; b=qrN8CBee+Svy7hA4j/FpmxbcWu/1TbG64ZDczXTGw6X+6KYDmhIH9eKINcxv6fs8M6SEel4OE/S6s8ud44dpJYvnZNsolPioTAkql+ZQvI1x0H6EY+YeoYDD5LXHlV0C7L1dYl5TTMD1OC+o+vn1l5U6rPUZK3uGZiwzBi5ryDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763180517; c=relaxed/simple;
	bh=W7Q6wmI9qY9hFy3y3Yc0H0YKLHAJOByL64hTBS8BJ6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DocmJ8yXzop0ZH7owq9aOj8htkXwkstzBnqTsDtOxCzK+fLhtKLXy4YmPwEmkpA4ZGqlIjzwPDJ4i/sZRaQIRc5ADXHiWNhTivP1quOjQ+XTP3jFCwOiEDeWBYxGRpT7tDJiftmMpUumJQ9WzpHO2W7QuH5EZQgHiCrscqHmjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ipw5tVdT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mDufRdfy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763180514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/tk0v+4BBK6qP0Q9YzuiptrPfp0eR+Hy5aITCdFIu8=;
	b=Ipw5tVdTexLVBE3gaaRrLbizjcEfV1YLPucMZvteERrkfqWv2fVM6FB41MuyKqyWlzVCLl
	T/B2F9OlMubLeaCq+yoUfZp/CxGbhb/6AH3nHD0dJuxqqv5u1tGCbQ+43OO86cYe19n3PK
	1NPu8PDMWkSycYtTZSuOn1vf0+SEm1E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-fY3Rp3dYOX-tM5RifAVMYQ-1; Fri, 14 Nov 2025 23:21:51 -0500
X-MC-Unique: fY3Rp3dYOX-tM5RifAVMYQ-1
X-Mimecast-MFC-AGG-ID: fY3Rp3dYOX-tM5RifAVMYQ_1763180510
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29557f43d56so34864215ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 20:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763180510; x=1763785310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/tk0v+4BBK6qP0Q9YzuiptrPfp0eR+Hy5aITCdFIu8=;
        b=mDufRdfyb3+3CvLfM2VfU6skSl10O6kBApZSJZgrHfaXOmnx+j6ezg6w5+vPJngR2l
         y1jQlCRClR7DIZF1C+bzCfjxLYqQ9/Q99I6v1/L/LgpSWYBcxZvoxIE3ulFf5dzuVzat
         yBy+nNyQllDj7+tii4l0FcL8S9+ehpcyeyIrnj3JIGI8sJhSmhU8pBtiGgk4VnNHyX5J
         3cAmeq9Rh2g/8KeuA+BOBJw6qCNh5mhoq6Aw0DwmsT7Zl+9vmOqY6Gpx0/hHpU+8exfh
         nS64j0CEcnrp4jDxlZHxZX4Eme2b6LpbE8NUm7ODxpNDe+Ya0pmL4DCj9f44j171ehLV
         YyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763180510; x=1763785310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/tk0v+4BBK6qP0Q9YzuiptrPfp0eR+Hy5aITCdFIu8=;
        b=Zx16YhIuCjFOMquMsDP41WiaXEwDZu/k5MHRBiPwBpXtYDsEZwY9qb9eJ1lfwmoqNG
         I5QC08KqV+FFAV+59/OClQFMlxTf/iuDNjS1ADZIrH7BIoBqRjb0Lf2JfcVrz2IKCWtU
         R+zG47gJLg0V+UznlabzEov7D8EVHzUa66hpDKfrIGA35a6gCyvPrzdyGpyDmyV+FXec
         2Tlzzwy1y95BMOZ68JAPgw6upaR745KkHhnksBo7A5POzQel2e3KrzJk9q6txgSI3CUo
         0phHnOySuIFsnmLkpKoQNc88fmuu3dGdmHTPzSfErpbLKqAWeb1oryVWL+P2hSbXH8yb
         F+xA==
X-Forwarded-Encrypted: i=1; AJvYcCWhfcmxIXPmDao8NPYpo6tVBKM9QArCD+XWyFGPUnevgln97SPM1HVeeWRHvdwHGeMc2G0pjY+i1dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKhrvOed52gfVbOQPf0qASzmod+IhGFOXW0EImjsR/89S89k3
	m4a9H+/m1ppqeT+faZKJvUba+vDrs4LqP8iS9vftDa2sEp0WjtbWIiL2XsjIDVMvq/LcFZYtZ8l
	8hcb3AvfOg/2C9YTUxM33RirFu7gP/K8O1wAOZIO6TuPoRMnWRTDgBrK89OIcsCXTcPypKAGaZ4
	//Ad6OgFsPBeOQZx7ttu5WTLpZG7FfOJA4zOgr
X-Gm-Gg: ASbGncvOIYN7ITw1OIoyi+B/YmVgd6u67lZBwBK/gUuSQ6dpVUrKOUyGOoDWb/3KFs0
	gr6ZPEYVUn7Jv+qU4WyPwxV0fNI/wchHvQMEu1acZ5nFZNHVDezV4A6Z9owtkXiE9CAsBcLxO1k
	M6dEHiHfXBLBVnPRUtBpRn0SaEY3W65lRJrPlPKLOIiIyDt3je/C4txU+O
X-Received: by 2002:a17:903:120b:b0:295:987d:f7ef with SMTP id d9443c01a7336-2986a6b5698mr58952645ad.10.1763180510134;
        Fri, 14 Nov 2025 20:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpWOiKe/yoXVPzbbB8ra3b08yL+JrFximT86RMx9yWBQlaBgFV6FIkea9RBX9X7EoOn4xsE8DGGa3NwoDYNSY=
X-Received: by 2002:a17:903:120b:b0:295:987d:f7ef with SMTP id
 d9443c01a7336-2986a6b5698mr58952445ad.10.1763180509717; Fri, 14 Nov 2025
 20:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113214540.2623070-1-elder@riscstar.com>
In-Reply-To: <20251113214540.2623070-1-elder@riscstar.com>
From: Jason Montleon <jmontleo@redhat.com>
Date: Fri, 14 Nov 2025 23:21:38 -0500
X-Gm-Features: AWmQ_bm8Az7GW4XBfoBLWD-9SdtXqiB6zadKcTvspIsW8QHKFXbXxVXEFbaU15U
Message-ID: <CAJD_bP+AjhNCB6kCeKdnXERjP9j8dhbCejnS1OVmFf_VShti5Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Introduce SpacemiT K1 PCIe phy and host controller
To: Alex Elder <elder@riscstar.com>
Cc: dlan@gentoo.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	ziyao@disroot.org, aurelien@aurel32.net, johannes@erdfelt.com, 
	mayank.rana@oss.qualcomm.com, qiang.yu@oss.qualcomm.com, 
	shradha.t@samsung.com, inochiama@gmail.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	p.zabel@pengutronix.de, christian.bruel@foss.st.com, 
	thippeswamy.havalige@amd.com, krishna.chundru@oss.qualcomm.com, 
	guodong@riscstar.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:45=E2=80=AFPM Alex Elder <elder@riscstar.com> wro=
te:
>
> This series introduces a PHY driver and a PCIe driver to support PCIe
> on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
> Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
> PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
> one PCIe lane, and the other two ports each have two lanes.  All PCIe
> ports operate at 5 GT/second.
>
> The PCIe PHYs must be configured using a value that can only be
> determined using the combo PHY, operating in PCIe mode.  To allow
> that PHY to be used for USB, the needed calibration step is performed
> by the PHY driver automatically at probe time.  Once this step is done,
> the PHY can be used for either PCIe or USB.
>
> The driver supports 256 MSIs, and initially does not support PCI INTx
> interrupts.  The hardware does not support MSI-X.
>
> Version 6 of this series addresses a few comments from Christophe
> Jaillet, and improves a workaround that disables ASPM L1.  The two
> people who had reported errors on earlier versions of this code have
> confirmed their NVMe devices now work when configured with the default
> RISC-V kernel configuration.

I successfully tested this patchset on a Banana Pi F3 and also a
Milk-V M1 Jupiter by making the same additions to k1-milkv-jupiter.dts
as were made to k1-bananapi-f3.dts.
I no longer have problems with NVME devices like I did when I tried v3 and =
v4.

Tested-by: Jason Montleon <jmontleo@redhat.com>



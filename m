Return-Path: <linux-pci+bounces-14784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAB9A243A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2668CB213E7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279A1DDC37;
	Thu, 17 Oct 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i1HBmuov"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F19C147
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172970; cv=none; b=igjdcwQ437IGJ8GY9xt8BpeW1VUenYBIY8jzD4kubNbD7drg84e6Bq05TmGV+StCc00qluQcKp/h85wgVwYe+N0dE6BpYDaMwxH3k83YsLM/JpeYIczin66HECbCgFUZ2Y+D+b0Ax3GgLfNZeFRER6LxH3Lsfjfg0amOPnsWMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172970; c=relaxed/simple;
	bh=UJqO2BFWnJpl6c4qm9egZxuBzIzCsmzQFDLnn4xO+aQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdIy5RKqGMaTBV1XhGMFeDBAF56sI9CgBJu4EWjXvZk8qLIlPCFAZ3F/IFZNsX2ijFWvD/PzYhBT3AeZxz9kfrfxC2jjyTIBPBqmveQyXILcyq2GarIZXdJe8HYzaCLYnhm1Ese1Kwx4hnykmB/+DoLmGvTt40GqzTtJUqF5SM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i1HBmuov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729172965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNf8lHsoPwrlsxVpfhmkSU98SQdpX5wGBJqf796QQlg=;
	b=i1HBmuov0DmeOem9OBE+66ZwIvnTu7NomcA26Az/55nq3rSGILhW6nxbQg6nGEACs6u7hm
	hwafQfyJlic8ME8u073vmJQK8H+IloHdWCijbcz/RdxsiquoHIjcmzB3/yQ7kWPtPEFyTh
	rTsL1NVGuYnQgatzhJw8OiAIG/7YsoU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-G3YIFTxNMnm-xQJQKcggXA-1; Thu, 17 Oct 2024 09:49:24 -0400
X-MC-Unique: G3YIFTxNMnm-xQJQKcggXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43052e05c8fso7467055e9.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 06:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729172963; x=1729777763;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bNf8lHsoPwrlsxVpfhmkSU98SQdpX5wGBJqf796QQlg=;
        b=io+aL6WxE+HoAUeY0QMAq9D/tqWvew4B8acWbNN+/JqlA1x5kcnAlHumVLK9NhqoZ+
         d9AkdpiRAqisVLBIzPaVw/2rorbGlCQJ3J0iPx/A6/okzw0tnHQH9oOBsxurfKQXNGWM
         V8Dy6UcYnGDzrS3EZfd3q0zzzW0Z4/9d4KhhT8Nc43rmGtsgn0cG1Iztagv7WrUYCoOd
         p4QCcPWR2HDHOVLaYQ1NnT6XLFm3rwLaTaGhnfnfrTcaMd324KJYhPIXgMMjGGZweROQ
         ppnEcpb/WScF406UCO276myJSs/eIXfAnMr1V92f+wv2KQnTyWQ78vbQyLQ5hOtuxxQj
         ve/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsbfIX+Uk0w/ZunLZULLv+PyW4MLIiZ8Iq8H0pJXtC6GNO03o59m15gY16czu71D92xuV9jKg1jUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3FzPyXUF9OVq7HQQkxVuOQfNkL2tcaD8CPHDRjKqpoYTZGr+
	RD0ovOsuOYG1nbPvkJ2PO0ZOxUzsDe2DbtF7dRN3yU6NTRxCKCXSTt9uRxPdxuk+JNFmebS/BY4
	l0FUeYcmij5ITG+pWOjcGbHaqhdNNE68YWbqQQYE4vpA8pq+KbdwZ8t9lSg==
X-Received: by 2002:a05:600c:3b94:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-43155afae76mr36850275e9.33.1729172963003;
        Thu, 17 Oct 2024 06:49:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE59ghlSm/r1F2zW+K6I0ImyWECFDbS8bjiEE3OExKnAO6buqdIFsvuMEjWIWmzxTwikE8TQ==
X-Received: by 2002:a05:600c:3b94:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-43155afae76mr36850125e9.33.1729172962615;
        Thu, 17 Oct 2024 06:49:22 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87ec5sm7322128f8f.37.2024.10.17.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 06:49:22 -0700 (PDT)
Message-ID: <23927f7a574bd4d683c07069e5cbccdff8ac14d9.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] PCI: Improve printout in pdev_sort_resources()
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 17 Oct 2024 15:49:20 +0200
In-Reply-To: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
References: <20241017095545.1424-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 12:55 +0300, Ilpo J=C3=A4rvinen wrote:
> Use pci_resource_name() helper in pdev_sort_resources() to print
> resources in user-friendly format. Also replace the vague "bogus
> alignment" with a more precise explanation of the problem.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Philipp Stanner <pstanner@redhat.com>

> ---
>=20
> v2:
> - Place colon after %s %pR to be consistent with other printouts
> - Replace vague "bogus alignment" with the exact cause
>=20
> =C2=A0drivers/pci/setup-bus.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..0fd286f79674 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0	int i;
> =C2=A0
> =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> +		const char *r_name =3D pci_resource_name(dev, i);
> =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> =C2=A0		resource_size_t r_align;
> =C2=A0		struct list_head *n;
> @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0
> =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> =C2=A0		if (!r_align) {
> -			pci_warn(dev, "BAR %d: %pR has bogus
> alignment\n",
> -				 i, r);
> +			pci_warn(dev, "%s %pR: alignment must not be
> zero\n",
> +				 r_name, r);
> =C2=A0			continue;
> =C2=A0		}
> =C2=A0



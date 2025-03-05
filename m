Return-Path: <linux-pci+bounces-22926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F27AA4F331
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 02:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB133A4474
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3CF4AEE0;
	Wed,  5 Mar 2025 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk6OR4cd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BE1E50B
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136676; cv=none; b=LsLtqMgSFpM4gkfZDKngLfb5NQaJCXl1tng/Vam3Q+nGSjFvZgOiG8qB+gW7IQhQ52zSTnSV+Ov4GTwY4leqKu6+26HSy3YCwXVyN8hgDYkIrQJt87Y4vRlQkMEa9EQpuYyRmupz1FTA5YTCID4UVNsHsVbrDwN7btcGVzaIAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136676; c=relaxed/simple;
	bh=USKflyZu1REkdqmBGzIWDWFiVN0yuYXOmOs8XbNpiyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OO8A7W9SHEv/7chzsCebCjh6VmJfhQA8O/WihUoQ+wTkNkuyNd0O+xgyg3dmDPieVt8YdgE6fioojTxz8LatejMMf6CffpUeUrjPqKKayQBY4D0XpBDdGjaiTntKVbrG/nEw1KjQNrcG4uvl9cYt00A+eNLPu2hOHtw+KDA76dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk6OR4cd; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaedd529ba1so721079666b.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 17:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741136673; x=1741741473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USKflyZu1REkdqmBGzIWDWFiVN0yuYXOmOs8XbNpiyI=;
        b=Fk6OR4cdKeCoj9DixOzek/Dip3UxZSJJD9mhOxqXDWuwihZzAE1uNr43ASrbJSIKkZ
         D9VdCKs7qzT6PQFuRN3+gqRckU68mnLDfuKwAvTSLhu46UPealNlnau31tGcVr5lZAFS
         aQEHvyBFZoAaT61mbp+z+w4o8BndS/yW5ZG7+3gYu+Z+D1HyisvK1Cg+fCxK7UK3CLOg
         NEeAMSFHav7QZ8jlwyhmVLmz2GOpSTHhKmzIUXsmH/MAigUd9ElC++4JNqWy3rnxgUtf
         GyrUJlHce5GCmTp65v19clXbDxjQaJKvUL795wr4rIjyrKRFvF1MNH7wMQMvCOlzn89j
         Jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136673; x=1741741473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USKflyZu1REkdqmBGzIWDWFiVN0yuYXOmOs8XbNpiyI=;
        b=YzhVhd99Ie89w//Mc0vhVd3Ca8CUlU14QsZvOR+csEq1DEanHdBK3ui97I3Wc92bZ2
         8yf4gKKM52uylZrUI36U3hmXUB1bOIl78EkKNn/s4ux2D04AQv0JiRFz8bGMrm5cG2lH
         2DvBS/u0JMq6bUc8Bt00pBSQgoMHe98P196R4zZWDLK4t6a3omHhB0gqYnFOZIDq0JCc
         mEoOfZjPeBmkpiZbny++PeJ46jOgQaxIrFNid6J1T2o+ii+MsI/DbFdwcwyUZF4KEhAM
         uVq+4ZomvdLnlNz9VBRxcNwzwg1g/1n/Z3IH8RYbKZAVe9HQ6bgoiUE4otyhoixJOjxE
         VsLA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6GnsZBfr5slpgJ7LOi9iTK0nG7B4+qGBMl69csJBvekavvmQx92CcR/Wv26tSgUrsfTXbTgiLpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGH5J3+vyS+MZ1Prs6J/a0TP7AKzoj/NlIgkMrOU/ddbDI/q4m
	J/lOvZ0eO8BTvBoQPYAjzNrAdL+Inoh5qYUM03I0MpUY3Ify9F47AXCikD2vtSuLzZ+W/paU5hm
	IoaKi8bl3t/xKqCoasUT0vbE60+WuyvxmB2ti
X-Gm-Gg: ASbGncs5xlZ5nj5f2jhMlcsv7OKSz/hcm3TXT8VTkb0Ne9BRu+LOXORAhg366cDq3cq
	bjytvrfGmy1bu979IBCElsNS/cU4S7LuFoy1fR/6q6Ms3UZ81UkzEuR6TY7L6UnrxMgNsZFX+6p
	tkANjbf+Z0UHriDTp/HcTpo6FyfkIW5wG59Pstkc3Rr2L2DwaiQ2Udrsqy
X-Google-Smtp-Source: AGHT+IGneIxlsJoV3R8qezmRAvVGMUwdKzDtt25Doe8N3H1CBT6BBReYu5q9gv93gIZXXCKjc8FxTevb3JNblGmBVK0=
X-Received: by 2002:a05:6402:2114:b0:5de:a6a8:5ec6 with SMTP id
 4fb4d7f45d1cf-5e59f3d3780mr2480427a12.10.1741136672864; Tue, 04 Mar 2025
 17:04:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214023543.992372-2-pandoh@google.com> <20250304183221.GA250118@bhelgaas>
In-Reply-To: <20250304183221.GA250118@bhelgaas>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 4 Mar 2025 17:04:21 -0800
X-Gm-Features: AQ5f1JpO-ffmbaa-kpaGc_5it2ks8U9s79ADk_gudQL0RIaxjQsaPVdxhKdNER8
Message-ID: <CAMC_AXUqLYb=qr+EW0WeKq-NW7wQwNNi14Kc5k-6XmtXNiC18w@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:32=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> It's true this is redundant information, but that e1000e device may
> no longer be accessible.
>
> In that case, I think aer_get_device_error_info() would probably
> return 0 because config reads would all return ~0, and
> PCI_ERR_COR_STATUS & ~PCI_ERR_COR_MASK would be 0, so
> we probably wouldn't see the e1000e messages at all.

Wouldn't we have larger issues if the device is no longer accessible?
Would a log suffice in that case (i.e. when aer_get_device_error()
returns 0)? Something along the lines of "{device} is not accessible
while processing (un)correctable error"

Thanks,
Jon


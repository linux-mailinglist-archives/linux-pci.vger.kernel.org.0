Return-Path: <linux-pci+bounces-24395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C15A6C352
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 20:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3133B3CFF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6FE1DEFF3;
	Fri, 21 Mar 2025 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glTeAWO4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E0E1D54D1
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585192; cv=none; b=ABnPS/7X46fsRgdRnxfQjuAYK+/e+L/zYgjrsS9ih6weXXKbQdGvVsbogsWX24OaHl0+8Sl1uOs+Pz8dvccXEquCwn0jB8H38awvJGuWSmQP2dVMmdB6fV9an705g7E1fei1rIG/EcIWhz5mcdMiyUtkp70Umlfu9MroISA8pZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585192; c=relaxed/simple;
	bh=v5KtOTNIkW76SJrnfubH35VIVDZstbWxAwAjU8+UdjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3ZA9R4nlZbP87Sx5WtXFGribxVg1mNWPIIsp81kRgwc70WMKO+EkSJcg4QH8O6BcnfQmDiv6KN3LCsV1g6TTjQC0HxBTL9YgyoqCuzh0IZfpHjahMd82ObSEKFYSEmBNlZ9jAPR1ktreLbLe+o4d+1olBMfvw4MZGPi9wl19ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glTeAWO4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so3817227a12.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742585189; x=1743189989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tng6UjipctFtDfxhMerRP0haQzcsPpyH85dwcCigpU=;
        b=glTeAWO4ocKdsj6oYXWgNx7blPqCvfKz/2NW+ovnUJmYr8SoJwvxFdmBwjPW9G34ds
         ZCam7VrbRK4Akyqv74VX0O4mY4+YW/d5cNDgb6V+Y6xwWpAz195r8JcwrIgQCFGQlGJV
         BNNSHFhqTclZTeyUxL1fbvEZocq7FjJ+SbRVRj5qm870JoMxFM+8q2H5qTywjCnLkRVC
         vJZpFN9Ljom1KYdhgBI1de9y8KW8iDMibp/JBHBUZsahVRhCSmCpmaVLHHb/R2buCi0t
         4lGdy5Rquuxye4QX10WXrbq/bj9bkSpRwj1/N/r4vECYbpXJArPkwnjAOTDAKUqLASCr
         Kb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585189; x=1743189989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tng6UjipctFtDfxhMerRP0haQzcsPpyH85dwcCigpU=;
        b=gHQiWIVcK0VWQirwLbe0DRihZcfi0hYYlVnrkN0AA2/DKOpTXdozryctfok/nsOkzn
         FmfDSiK5UUX2diSm2CqOmHE5e9HnGKJ7P7ADnTVYvmR06Yd6m14ISabYuaMzL1MJt1i9
         hqRUb8fgGuojwCxRyU9EkrS2ZEN49YPFiWlPDCqqyVnp1fYdjXTPsBq//oprubmhWKac
         1MlzqjGKBIWfQ+k7f/bYRLLULALD6CowgM+NaVwBdUw4dj9bzHcYg12PLK2d2SRi06Uu
         jtI/CEj1EHbmeKGuICd0urJY2/sWha3V7ETMNbFFPmk3EZpS4PGyy/oIUzK8jwIC2YxV
         bZsg==
X-Gm-Message-State: AOJu0Yw5Drqeg82F+XpmjrJ/2fjOyTkz2oU/YRXVDRk4/+5SzMl3E8eW
	/izvpZoh5az7KNLQkVqUWMCdJymmk0FY8jzSyG46SaAks+AbSXaixoYMnLRfXu+OIa2/a1SmEyk
	h61FmP7erS5+Ty/E8De4jRzPSiVVzSTX788U2
X-Gm-Gg: ASbGncs/a3fXwVWLwP36T9YwyQrvLxDP2cJ6C8VXWCWhGc/V7UeuJWwdSYWCKCgjqeo
	xgJz8mWPVlPBArjztFuDhh0emJqsFnhgt5+EBY+giaRe9hvGAQ5rSrFjKEEn+KC06p1vw6J3SNF
	RbDFD8Bc4R8beqQdnpYujWT0wMWF66JX4fwuvkxR1ZsSUJ4R7f647mrGG2
X-Google-Smtp-Source: AGHT+IFdVy1mx8ngQrdtIbHXa6JnfMbBOXsxmz85aPdUtkVeTQRngXqptM5GMwMX7zVVhec4bygM7hiK8NuAwKtSkwo=
X-Received: by 2002:a05:6402:3495:b0:5eb:cc1c:bb9e with SMTP id
 4fb4d7f45d1cf-5ebcd409024mr4846295a12.7.1742585188749; Fri, 21 Mar 2025
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321015806.954866-1-pandoh@google.com> <20250321015806.954866-5-pandoh@google.com>
 <f690cd8b-4d11-4fc6-8ae8-73996b7b3c21@oracle.com>
In-Reply-To: <f690cd8b-4d11-4fc6-8ae8-73996b7b3c21@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 21 Mar 2025 12:26:17 -0700
X-Gm-Features: AQ5f1JrrLcN7rIjmcjR0AEKpYXFUfRg-lKFCy6IhRjDZ9vlVWDE3LvwPIae1hHA
Message-ID: <CAMC_AXUqd4jZ-XzSSMBh6QXXasAsc6f5DGss28iv8eBdszuXjw@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] PCI/AER: Rename aer_print_port_info() to aer_printrp_info()
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sargun Dhillon <sargun@meta.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:39=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> This commit description doesn't provide enough information on why and
> how we make the names more descriptive. With this change, we want to
> make it clear that this function logs information about the Root Port
> that received an error message, not just a generic PCIe Port.
>
> Also, there's a typo in the subject:
> s/aer_printrp_info()/aer_print_rp_info()/
>
> I'm fine with the code changes but I'd like to see the new commit
> description before giving the r-b.

Ack. Will add more detail/fix typos (incl. s/institue/institute) in
v6. Something like:

PCI/AER: Rename aer_print_port_info() to aer_print_rp_info()

    Update function/param names to be more descriptive. Make it clear that
    this function logs error information from a root port vs. generic PCIe
    port.

    This is a preparatory patch for instituting rate limits on logs. It
    frees up the dev variable for source device iteration.

Thanks,
Jon


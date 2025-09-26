Return-Path: <linux-pci+bounces-37104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE3BA4410
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736AE168588
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E017A156236;
	Fri, 26 Sep 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElFc6G7e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933013B5A9
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897546; cv=none; b=JCz9xY4/k+cbRghJY7Pj+EYxSqsDB6KuNFlBVC2GEhk+i+/SAwn+lkbe+4KOgQ7yYLUAfEobwWlmeLpxQ+mwfaNczCbV4KsejZUi0HZ7frWRYbiQi/LMkj5bkKpjYKdBsqHV59aLC3Yrji9UrVpdtSEo4PSqZKGOQydN5binuZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897546; c=relaxed/simple;
	bh=GR3UhQsht5K0Jwq5rBXb9dgUoosX34C002/S7elTLUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piUXUV54f+LMdbHxpA38H31k5jRdxZBLnuPljv8i9oVI1bR6/IPWQiPnXEzuZJKDlMrO1xGEMFB/FrNZOYIzFCbEifAsDkOCSshAlljn2H4+FsD2rSQQ0nwRWjL+aO9jSfKx0wCD/+jajRMHPdtK7t6ffUM4o3MFZMhv3TOeTyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElFc6G7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668EDC4AF0B
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897546;
	bh=GR3UhQsht5K0Jwq5rBXb9dgUoosX34C002/S7elTLUE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ElFc6G7eZh2BJ0ifxZKpR2ZW3aV40Xpz93WcjrYBNqlFRkd4KbJnGk4vBbqr6fzE7
	 rWks5qlWg6XaYE8iGxaZ0oahv381AUWBEhjA/ZjDWIgSpGzic94sEXEuUdxIbWJYhD
	 5Sq0Jrarm7ad/NszVDm0BX3XLSCNJCkrCm1y/pwixANkxQ+tWsk5bpixRzr0Yn6u0S
	 RzaFH9VWX+YkwcBryUCfVluRe2q0/dPDxg+CzozyIICwIArfhqFcUCuaSJOJHCE21l
	 g7i/dj5ZoxrndeIiMW4wmAHpQJe5w6vR78GIJC0pOyqNGXoqSe5FDhMVebAj5IX5Dy
	 fv2D2XargmJ5w==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381e2079fso2087268a34.0
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 07:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHN6V1sd7YrGCAJ4FwR/mi715GDWtVuVzi2ui2TE8pj9TAdCKK0uC/PrdQIqDEOiI/JyT9plvx0YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlisOr5W2H84KyDDq2OfrjaQHPWIy8EsNpGDTfAIyzqqDyHdVQ
	yErXOqD8HlPogg1dPAC2LZNPgD97WvGgXWlEOTuagD+f3l5MXjxE8vRR18CeLMaZ7a837rHsbRn
	DjAtF4fp8K35GqDTT9FCRK1BKijZo7J4=
X-Google-Smtp-Source: AGHT+IHJHaKvdI68QzUrzIAL1Tex4SlePhlPJbUCP0LntCMfCY3uISEcIn/T2FEFBcTugpvP2WZJI6kObdQ5unAgV7g=
X-Received: by 2002:a05:6830:6615:b0:745:9769:ea43 with SMTP id
 46e09a7af769-7a048362392mr4417572a34.11.1758897545660; Fri, 26 Sep 2025
 07:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1950293.tdWV9SEqCh@rafael.j.wysocki> <20250922185036.GA1983521@bhelgaas>
 <20250926150613.000073a4@huawei.com>
In-Reply-To: <20250926150613.000073a4@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 16:38:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hX_KwigOroX1JNMEPbNF5R1csN7zJVenKAPTHtzxQ_Qw@mail.gmail.com>
X-Gm-Features: AS18NWBV8t3xxNWpfT7og_6rkg4uGmPJmoV5hPwGaOLV6FHNIUYqC7HibpY3w_0
Message-ID: <CAJZ5v0hX_KwigOroX1JNMEPbNF5R1csN7zJVenKAPTHtzxQ_Qw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI/sysfs: Use runtime PM class macro for auto-cleanup
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, 
	Alex Williamson <alex.williamson@redhat.com>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:06=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 22 Sep 2025 13:50:36 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Mon, Sep 22, 2025 at 05:31:53PM +0200, Rafael J. Wysocki wrote:
> > > From: Takashi Iwai <tiwai@suse.de>
> > >
> > > Use the newly introduced class macro to simplify the code.
> > >
> > > Also, add the proper error handling for the PM runtime get errors.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
> > > [ rjw: Adjusted the subject and the name of the class ]
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Being half asleep I went and  replied to v1 when v2 and indeed this v3
> were already out. Sorry about that.
>
> Anyhow question is why not ACQUIRE() and ACQUIRE_ERR()?

See my reply:

https://lore.kernel.org/linux-pm/CAJZ5v0gnqoJ8bALZT61ZvTA=3Dchp8y5QBiA7ZpNQ=
6fFJuQzZUnA@mail.gmail.com/

I think that it can be done though.


Return-Path: <linux-pci+bounces-2557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4C083D0E4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3211C243EC
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE92F125BB;
	Thu, 25 Jan 2024 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bzP+HFTJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B1111BF
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706226355; cv=none; b=hT0+jwWT1er/247qB23AhZA+TNZqvrCMxiaZfqHwVj8kqjE2INBQtF3dnMN5QoF7NxkXy6v5Q7KyWCqyAj0GeLqbr3Kot+J7PyufvC9RSyzEMlZOgii2oRF7wx9yR5JfeX9FMS3LDMoW1jg9i53cacB2fq/hD3YQ8VufZgdg2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706226355; c=relaxed/simple;
	bh=LXvDRzf49Xc6i7nbu9yyGuvjQOAoA3TL234yTyYg3TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6sUA78D5vRUsPWHutfjZTc12ZA5m1ayQQCtYSFAwFWrbSd5O/SZ4rMiun9jRacM70fpgntIeRc6kU8yXxEFpxT8G5ePeRe/IPc1sPwKA5TgPLWBcH0XqlNKbfRc0YeHcjgDxatf+/td1CFlkkAGwY3W/BXKiz5eUI957XaqqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bzP+HFTJ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4bd7614325eso898940e0c.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 15:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706226353; x=1706831153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXvDRzf49Xc6i7nbu9yyGuvjQOAoA3TL234yTyYg3TA=;
        b=bzP+HFTJN9qJRVR6nRggpZsTrVSSLwk8Y3qJ1yMWERbQc13nA7/NI+N7pAroChQ5fy
         Dr1cG1lDBEaFUBTcZX5bNQ8hYQnQcBymvo1W5UGmumFZfCNda9IFXVh5pvHoVIBsaSU6
         m8KF9yDDxv6XWOBfF11VQKdVObHdxkQpkvV74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706226353; x=1706831153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXvDRzf49Xc6i7nbu9yyGuvjQOAoA3TL234yTyYg3TA=;
        b=WE0Z/6opdYqOZt1Bozfsv1XIZrag/X6J44thFoT1/nwxtzOaL65VRdcjhIpuVzUtWP
         g+p9zB22sH0agK5obVzcf7iF4GagoPJ1hLFqnf0hW4gchLj3FuOaFymD1g0ru/Q+lGMb
         KGc/TO+4zgItVCGxDFwN3FmtTlB1KZyTgctP03kaVkSc1A+kZIw3ONla82lvSPeN0wpJ
         712hEPw7oigAKL1NDo8Ppxz1oVSDRmxilRNPlxGGY92TS1lbfaCV9Yrj+PFwkwskpztT
         g/O43PYBjG4z4mvTk+i2o5cTpowc7MlcIZZfqk/OfF7mp3LkqmsSvSGTtezPu2BXwMtP
         cfzw==
X-Gm-Message-State: AOJu0YylS/1SIU8fzqi6fTFWfo9ZL5EUPMTlwCN5knpvvjqDO8szJdGh
	jSZewnM+vQ+U/r8keYz/mtK/2rg0uw/EY6FhgXhhLwwHnmRttvRks82XBBkeoTJqufZIsAF+FsT
	XZYQ8FzfToJCGOOrouCcZePaqDcDwAuhXPvoA
X-Google-Smtp-Source: AGHT+IF2+F505DKuWe7knptgJ6CrgZ6lJYDfYgxq0eDiARp7SSTxq8AnE5m0ctWL4L37g8+L1T2m1jJz9ZYlvqQ+HGo=
X-Received: by 2002:a05:6122:2001:b0:4bd:54d0:e6df with SMTP id
 l1-20020a056122200100b004bd54d0e6dfmr40784vkd.1.1706226353098; Thu, 25 Jan
 2024 15:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228132517.GA12586@wunner.de> <20231228133949.GG2543524@black.fi.intel.com>
 <CA+Y6NJFQq39WSSwHwm37ZQV8_rwX+6k5r+0uUs_d1+UyGGLqUw@mail.gmail.com>
 <20240118060002.GV2543524@black.fi.intel.com> <23ee70d5-d6c0-4dff-aeac-08cc48b11c54@amd.com>
 <ZalOCPrVA52wyFfv@google.com> <20240119053756.GC2543524@black.fi.intel.com>
 <20240119074829.GD2543524@black.fi.intel.com> <20240119102258.GE2543524@black.fi.intel.com>
 <03926c6c-43dc-4ec4-b5a0-eae57c17f507@amd.com> <20240123061820.GL2543524@black.fi.intel.com>
In-Reply-To: <20240123061820.GL2543524@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 25 Jan 2024 18:45:42 -0500
Message-ID: <CA+Y6NJFMDcB7NV49r2WxFzcfgarRiWsWO0rEPwz43PKDiXk61g@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:03=E2=80=AFAM Esther Shimanovich
<eshimanovich@chromium.org> wrote:
> Next week I'll try those devices in our inventory to see if I can find
> another one with this bug. I'll get back to you on that!

I ended up finding 11 additional models with this bug, from various
manufacturers such as HP, Dell and Lenovo, that use the following
thunderbolt controllers: JHL6240, JHL6340, JHL6540, JHL7540. So making
this fix apply to all affected devices would make sense.

On Mon, Jan 22, 2024 at 1:10=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Yes, you are missing the 1. that it needs to be directly behind the PCIe
> root or downstream port that is marked as ->external_facing, and the
> fact that there can't be NHI's (that's the host controller with the IDs
> I listed in 3.) anywhere else except starting the topology according the
> USB4 spec (and the same applies to Thunderbolt 1-3).

Thanks for the explanation. I'll write up a patch that implements this
and takes into account all the feedback. Then I'll test it on multiple
models, and then send it your way. Let me know if it makes sense to
add you as a co-author.
Very much appreciate your insights.


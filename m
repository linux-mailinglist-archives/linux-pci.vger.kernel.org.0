Return-Path: <linux-pci+bounces-24287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FCA6B2BE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFD53BDF7B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF01DF277;
	Fri, 21 Mar 2025 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Amz3EOQp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B059461
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522132; cv=none; b=MTnJEubvPnaMnw9eRJ1Nwvk9pSwIIjun0+HSkzgKNDuiYBq8OenCSGi/swdYFYCbFe/7S8VddOjNpsoCuOwXvd+CZrJ0gq5glvbhtyrNDfTe3+bfQANMUfG5Xlb/Kdu7S5fOtXC7VXkiYDJB5wKveMuPLSOdbGjkHBy81NsCEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522132; c=relaxed/simple;
	bh=E87LO5hLU6WqRQvRsijyUdBccu5KSu5rxC7vVe79hxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m889zb2OfRiVqM47wzvXR0cu2Kpq2FY/A7QskxemBa1fLey9AbR5yXce+Gfyi8sp4FGDHI9KB4h4UcZiWIloz020geLx/7QQAXmlNOBSClBXB+MiYLur7n5GNGeFU/xrniTlz1xnT2Yn3PMLQPwufk8yxCJsFfU2UfUcJfUw56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Amz3EOQp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso5011794a12.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 18:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742522127; x=1743126927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82Ub2sOZ6DAanCz7J1tFi9h51yDnqjFCW55Sk1UVfmA=;
        b=Amz3EOQp2v2JrvOb2pF6OU6CEhBhlWamuep5kHbvPunfY9tZO5SSV3+tWEfIHoLNIb
         l+c87mcivEobcGbm+MyVzZX7smRMeRf34QsMjppsnDqOLE8EmHz+jHIp6iZfGTEFG/G/
         yYxQ5LKfHuTdyzubKqrP4Yk2iOggBCl3BVGbfCR1otu/zA1rcqcbeXeht01mOprHxcPP
         6MxVjmN16TbgE19a3Q7hw8VkfZ23834/7BCkzesRBmPl75BWdPX1DMNXmaBHzXiRzZB7
         Hdji/w0r9jyBdLW8kjegObHEVN1rzEvFAhBUizm8wLBmv723+xUWKEdom8WtnA6XRZjj
         ei4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742522127; x=1743126927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82Ub2sOZ6DAanCz7J1tFi9h51yDnqjFCW55Sk1UVfmA=;
        b=DZ38KRTBMhwLMg/792SOBoRKNLepPps80heJULJdiZ8m5Z1aR1GEV3IC2HLRhZQgxW
         WgLyBv/8JlB7tceE1DuXxEVVK7ISwyIGLORNmsmslxmRz/a3YtPQ9Nw43Ltcz7QZZuzX
         CJdF44nUjty/4fyv/Rlphd1ZmSDgEShSVgJoeRjVjiwo09fe7HMoYmHPu7N1r6zh1AQR
         V63LrN6Mt2aeNeFGWLKp2fRuUENUBJ5uOeZhfB/FNTOHr7h1XRZX8tFRIu30hg2tQZf4
         p69XoLeigm3pfVVqdTLnvrzz8r4JW0I+WpD9XvsugSKvad7haJsyjE9R2fQ8Fln4bfVW
         3qhg==
X-Forwarded-Encrypted: i=1; AJvYcCUtsCAZjD+p6YuwnYVyaywY0Xk4nEPv3S65QwovALnlY+S+D8qZ8v2JbFuHjVec5Hs8IEUmBw63eW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLOGwkMoT+CCRzbAorQYzv2oQioZuqhs+Fw02kEl2JJvJ56vT
	BweDb69hBYEJ36oTw39pDlJCznb1gCZhWDE+gsioMooFeqCb/AC57hHLT754BZkNu8bVc6bfy6j
	8CaBLmDpHJk3EMEc0c0+hLdpZs2DMXkqgOiQR
X-Gm-Gg: ASbGncu+RA7cerjwSWbVKiPBpPcmAQLSLeeTyKpVe6RS5FXnQealpxRuCBvTHp8rVhQ
	jbqeq6zzptO5oec4ehwQfUwVkripWntrztIPyxDswE4ou/DouvOO4uuItohLaiBf9OviE62UKFC
	ZfHSwcPFyNhS82cOqYOPAUtRJ5hjwiIAHM8kicGnaZbCeH5qzzXC9F/wY4
X-Google-Smtp-Source: AGHT+IEwhptGb0CsL+JQWtwIMo1VNcGU/XGIaZdydIpSX+/5GFtjiDth5mpjbnIg8FB5M8guxE1bEZ8Km28NAtv2eQQ=
X-Received: by 2002:a05:6402:354a:b0:5e0:8a34:3b5c with SMTP id
 4fb4d7f45d1cf-5ebccb9875bmr1548354a12.0.1742522126947; Thu, 20 Mar 2025
 18:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-8-pandoh@google.com>
 <d15a7845-dad5-47c9-acba-779c9b9ab5e0@linux.intel.com>
In-Reply-To: <d15a7845-dad5-47c9-acba-779c9b9ab5e0@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 18:55:15 -0700
X-Gm-Features: AQ5f1Jpn58sA_BNx8v-ubYCQcT2yHFAdk7OOeMUNiBPR-u5Wice_68JJGf7vRAA
Message-ID: <CAMC_AXWpaes+_ePGJtA0k3ZTPN0D=oXOTnS98iwgYoY-DZ+Cqw@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] PCI/AER: Add sysfs attributes for log ratelimits
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Lukas Wunner <lukas@wunner.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:02=E2=80=AFPM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> On 3/20/25 1:20 AM, Jon Pan-Doh wrote:
> > +What:                /sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs=
_cor_log
>
> Why not just use ratelimit_cor_log and ratelimit_uncor_log? Any way the
> detail about 5 second window would be available in the Documentation.

This was the original name. It seems to have gone full circle so I'm not su=
re
how to resolve it. Personally, I think Karolina's suggestion is a good
compromise
of detail vs. verboseness:

- Jonathan: ratelimit_in_5secs_cor_log[1]
- Karolina: ratelimit_burst_cor_log[2]

[1] https://lore.kernel.org/linux-pci/CAMC_AXW9nE-q_8qqX+1KOeYdTQVoUDovY03a=
PbLGZBpe9HCcWQ@mail.gmail.com/
[2] https://lore.kernel.org/linux-pci/d75a96f1-5162-4ec4-971b-9ebd4cfa5447@=
oracle.com/

Thanks,
Jon


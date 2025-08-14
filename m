Return-Path: <linux-pci+bounces-34061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E5EB26AFD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B121A179F60
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D72040A8;
	Thu, 14 Aug 2025 15:24:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB9188000;
	Thu, 14 Aug 2025 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185089; cv=none; b=AbVuB0khUFwAJsqA7avHmBpcBQE0oREBbte8cjvg5xfnG4PQVzU4bpaiXzQ0n8BavfuhXKx/pZLgihyxc+0T6IEzMyrpLqNHpwu4nTLFlI3w4T1I0ArtJeniXRtvqwKwtXzMwJGn2mKBVP3q0tBKW4AN8C/hy22imqtRT8VFTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185089; c=relaxed/simple;
	bh=5DZpdaxvf/xRii7FUNVA1jTQJH3GeudWV805p9bguHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loPiS8r7H+XEbJ0JGQvm8yL7Q2GaZ/3/31u4mJWiNasFKuvNkMhGynX9Jd4G2VH+I7O5x+tCfunnc9nUqY5xkrRLquDY+Tqoufl0NO+z1EuSQy4hpArUXEhlzb0shD+I/xlDAJvM0mNZmIOndoaPK7jXz3I8cf2KP8lH/fcnm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53b17552198so356105e0c.3;
        Thu, 14 Aug 2025 08:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185087; x=1755789887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6yPJNZcfaJ7QT7pxBe0aq8ErHvI9RgNKMxqHKrxf9s=;
        b=Cfsk9ekNDacDBmCZ71ayDonlfoKNfwxSVBvWRsKbeWh0gBFF6PLctlkTPWsYzChtQw
         t2ceQW9045P4/Zr0eXNS0ct9lTxMh/VCrrfoYkIajEdOorPA7raZlwvqVTcjFqxyrvbe
         ndXh1IwUvujI5UODpum24QwW71ez23Xsk8TqYyjtMM7oq1s1oDyJBq6YVVLFX13VobI3
         6eQ18Ng0EysGGSLYxkJL9eGIV2Vcp5HxFg4c/alaxZdyZ9/bqqEJ0QRTHpYGywEXcwdZ
         5IX+AfHQZNxm1pU+pYLawg5RThpcGsxhhKW24okfE58sSjQxNae6T6yuRU8svH41ntW/
         1I1g==
X-Forwarded-Encrypted: i=1; AJvYcCUUyo0Nf+4a8kb58AM+hRqHJF4oQwEPpga24l3iaf04vZ4rcIBN9EdH0S7AAl0t8bEXedH9di0dViE=@vger.kernel.org, AJvYcCXQZ3xTCMuVp7RkLQ6deFtA7lQw5TNJcfxezs5aB0uKpMZlRWO3XZtalFDF3iF4MZZIuN8HJVolyO8vnQmRYOJfJ2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU5rtFeDy5guBo64h/mWsIMnRaP4rAe4PYbdQ3tXWdC9OtOzD
	3AdiPCwenXIKlkYi8jOjDw5tte/WYz4xpKAHae1UN7xpGYEgBtjtqPDdfi88Qbwm
X-Gm-Gg: ASbGnct+0CaZDrIrKxC/76+eIUezCYpDLZJBDoPRw4txz3fThWE1Y2BWQXMGS20t2fI
	K72b0enBaRGZrmy8nOD57aaNCHnDr4oWHRwfL+xRwb+aM0v6nCnFczFR79D2QkQqirOtVVCggGs
	GKmKG2W6mmnlwkhlVayA5K8EbBgtC6fBhMwYswweXTCYflkn+3YKRwUtgrw4qu1PiEpAFWOVcrk
	Tvzy+jcv7nD1mFU/+lNUuf3KWf8TEGUF9FmAy4X4PYoortYTDclARXRDG92zsqvE1rBn9MCrxqk
	g+x9DTzrpfX88vBxCxCoXkumAlI7XCZB0EKnrFD4xzVQx4niVIbkHc/ab3rIFEgCDhSoVJNRGgi
	fokoHJrbxCLLDXLrHz9lIeI/3NKCCF2eQJNVljdFzlmbK+SlJMpqCpaBBARmx
X-Google-Smtp-Source: AGHT+IEWSOXV9r3jgZ1evFIc1Y7Y/uNylZfGp3G2SdHTXTE6y55O+0FgM8d5eFScNOIOqNy1eNBifQ==
X-Received: by 2002:a05:6122:3c55:b0:531:4041:c4c7 with SMTP id 71dfb90a1353d-53b190a492emr1122213e0c.7.1755185086201;
        Thu, 14 Aug 2025 08:24:46 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b02a1d78sm4559379e0c.25.2025.08.14.08.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:24:46 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-50f890e3df6so326537137.1;
        Thu, 14 Aug 2025 08:24:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYKtk73KtYSGl9mbDJ+vQWfKV2e6JbbjRxrisynHVKIQi0cBNmSEceC4+4zh9I24pBV+J1BXjInAJ2uo9H0MViz1c=@vger.kernel.org, AJvYcCXF4C1xoLWoPIMED0/Zf6NTMb9lHzjVNNLtwJCGMScndiCJ0koSLf+Om4n30tQEAqED9vHY/79elvs=@vger.kernel.org
X-Received: by 2002:a05:6102:3a07:b0:4f6:25fd:7ed3 with SMTP id
 ada2fe7eead31-5100292cbc6mr1148823137.22.1755185085609; Thu, 14 Aug 2025
 08:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814152119.1562063-15-cassel@kernel.org> <20250814152119.1562063-17-cassel@kernel.org>
In-Reply-To: <20250814152119.1562063-17-cassel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 17:24:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU2z8ZmUGNZ=81UoSmufp4K8yVhTJq0H6R0UvwB5Ke-Vg@mail.gmail.com>
X-Gm-Features: Ac12FXzLZlNOPJRw6_tV30FRN7vwIBtgsRTCT-SbGuu8yOO7JUbsNEQpGmoSTE4
Message-ID: <CAMuHMdU2z8ZmUGNZ=81UoSmufp4K8yVhTJq0H6R0UvwB5Ke-Vg@mail.gmail.com>
Subject: Re: [PATCH 02/13] PCI: rcar-ep: Drop superfluous pci_epc_features initialization
To: Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 17:21, Niklas Cassel <cassel@kernel.org> wrote:
> struct pci_epc_features has static storage duration, so all struct members
> are zero initialized implicitly. Thus, remove explicit zero initialization
> of struct members.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


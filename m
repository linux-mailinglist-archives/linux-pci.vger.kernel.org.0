Return-Path: <linux-pci+bounces-34062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1248B26AF9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A9A62767B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7117AE1D;
	Thu, 14 Aug 2025 15:25:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033D321428;
	Thu, 14 Aug 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185118; cv=none; b=eRIMe/SM5A29AUa4DtyzHp8c5gmO7zyZqklsaaw8QR0KKXv5hQLEHrg1B2CsyKksKYyf7GrQkKDryBMe75jkNKO+hzmnZk9gVgYfLX+YcWKki75eRNkMwCJEeLFMTHxk8xBTgi/vIynZlRrQidoJif5D/h6xe6N30tLvLP5NUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185118; c=relaxed/simple;
	bh=r9fJGuDSuYndaFU1MObuEg4R2VMgGBgbRbnRY8HDXrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQ4W+j5jdXc2td4i6B2CZD/sjF3T2mffCx1FHgOIdvXuq9QLKzob5Cqx2gmr5dorZSA4jcre923hoRleAWjN11IWuG057nFEN6wPATYXBHN8ViKKGvLD2HzphOx+SYL3wzpWlUUAd8LjVOinfWl0CH4UBg52jCqPgsYjZI7aakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b1719b717so906106e0c.0;
        Thu, 14 Aug 2025 08:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185115; x=1755789915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0j08yPsB9+eDDL7oe29yGd+1n6eT/MM9ci0IJrgFDM=;
        b=cZkMnYXa4NM5jk5C25MLk1DKo9w8UO8lFcdeouIHJepE5S5+5y9w4JzNdpd5uoZVTj
         mb9pCvxzzPPRx77uAbnmXyJDpYhGXmTc8RlHE0J1L3UksiFHHHWshRH4oMpDU9/NVnuJ
         /yPekqTN6LO0cyztHI+jE2xUhseQNFe5XOJjXlik7WxdZ3aZ3n+Kbx8VHnrToIkY0fmL
         0gvV++h+Yc57Klep3dNl07PKKNojpQDYdCBltuA9pbCguOHI73zgPE8X6ETTJd5Dgzvn
         XSemeq9Yo6VfaxrTPIuRoq2YobMkiTagwnUZUMiX0N9tbGBt5Wdva/F2tuI6xbjOLd8J
         M4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWdCOtL1jQaPZ/jG4Us8YQh/DAucoFuLin1c3SJ+pnUbTm5MksRb1oQs8pSWssKMv8DWZimUYWpRcI=@vger.kernel.org, AJvYcCXQlrOf9+9Q9EuyRmMQqHXQfgAwElsodR7KFeREfjOQcOSFvqgP6q3AwO4K3A3LXAYYPGDL0sAg/fPy2HyMBPABb2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2PoMs+sapEYe6oHq+5O6Wq7X77sMbiD1Ch2oTMkEvYifYt8D
	2ZgefuYhCJWl8MiQcBobxXp4f77b4E7awhLZmJYn5728gxPo1c77jfbVfO4k56Ax
X-Gm-Gg: ASbGnct67ltTXOkrRkVmyxl3HFzUeJssdRs7Opy5eOiOCC+XoQZ4gQZ4TJ9Mo4Seu2R
	IhCb3j59xyeTYFp2CJzs09FpV+XSFPEzwphUvsu6v3M4LDy6W/l/rr/pXm7f9zkX7AveDuIzoCm
	zMbS7Aajsi9zf54HL3+9noXpzDUsQ9kUjhzVZISr/O7J1aygaQecpKU1dfvlr52FD3rcztWroS8
	a90g2JMVaMvpr2HHbBS3YED22nBCQzYK0vLt6fWqYc+3S/mFWKy+TBDUKvuOC2DROmY8Ac3zXk2
	Q3W6RMrkHnIPH2PGw6OS6PJCVHZIBim7PwvtJHnMKSh9D/E1hWS3MaYPqIf4kg7ilRhX+BeKy9p
	2m/M5p66utTwwsKWWX3bNdbYesgnVDe1CjnIWyRKxk/Aeevd+rm7xpM6IciHh
X-Google-Smtp-Source: AGHT+IFjOR7ymlqzfYh9JTN/wMSC4LnFhSCxXP8o261hha4QPHUl3xSlAFVTksFgm7dG/h3GljTtVQ==
X-Received: by 2002:a05:6122:8c10:b0:539:3bb5:e4d6 with SMTP id 71dfb90a1353d-53b189a8faemr1519948e0c.1.1755185115543;
        Thu, 14 Aug 2025 08:25:15 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b02a3473sm4526441e0c.26.2025.08.14.08.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:25:15 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-50f8ad279f8so743037137.2;
        Thu, 14 Aug 2025 08:25:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvPLGIBQcejIoYEDfXoqFGm2ZiUorxIkSqg78CQKm7ViTRrrHhs5afVdwIeRfh75bD2aLRZBpbIMQ=@vger.kernel.org, AJvYcCVgJGGXbVcfAcbO7qz1z82M6JpyBc/yc7SrVg5F+NinfNjz/u2xct5Mv3Qj50BoN2YY6rXs9iI3viAdco0WdoGhQ6U=@vger.kernel.org
X-Received: by 2002:a05:6102:2c83:b0:4e9:d847:edb8 with SMTP id
 ada2fe7eead31-50fe0313077mr1557879137.7.1755185115172; Thu, 14 Aug 2025
 08:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814152119.1562063-15-cassel@kernel.org> <20250814152119.1562063-27-cassel@kernel.org>
In-Reply-To: <20250814152119.1562063-27-cassel@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 17:25:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUF9Kcf-6m5fk+KQ7hVfhr5VxB3LD-04m8i3FQhr9wiFQ@mail.gmail.com>
X-Gm-Features: Ac12FXxGmaMIRJKy1cNTeXU3DHCFewgjxrsFCCppugNeyaJL0zaKE3Ny4kMZ47s
Message-ID: <CAMuHMdUF9Kcf-6m5fk+KQ7hVfhr5VxB3LD-04m8i3FQhr9wiFQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] PCI: rcar-gen4: Drop superfluous pci_epc_features initialization
To: Niklas Cassel <cassel@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 17:22, Niklas Cassel <cassel@kernel.org> wrote:
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


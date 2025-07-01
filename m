Return-Path: <linux-pci+bounces-31165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B5AEF7B3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829E817ADC9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43223504D;
	Tue,  1 Jul 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHXypc1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061B21770D;
	Tue,  1 Jul 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371421; cv=none; b=rSUsy+qkbxvhx79NRu6hf1wuUr6ukka/d8zunrRkdb76TKYAIcQ05KRKcdlWdpm93R7Mir9UoCfmzNn0XP7tOG3yFH65NAoWzM8dyl8bo6uhLHNZAR1iKQMK8u8IkdNSwVGZPOt97VZwRFHHHuhtxqsAjuWeY9ytsbfxN+SkZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371421; c=relaxed/simple;
	bh=hmffTQkJsIUbZsQe9etVLoih9MD4juYOhq9sVIY1uaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQlkkoplBF83RjOT2fgNPM/8SQeG2ZvBkkzZpVL9FOI9GP85BrEmwIgR0Pc+MV+cUxbZVvS1IQZvdQt7p9NaO47KBGNMZ04lkoPq406IGmEDiCqNfdRFhUavgGcLRpQuSs1MR12sS7ykjW+2/vvP+mdpOVjSYkFHj0tNu3W21Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHXypc1S; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7d219896edeso585522185a.1;
        Tue, 01 Jul 2025 05:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751371418; x=1751976218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u96x1JfBwvgLGiFlKKRmBEu1YqkfwBmaBuctHI0YH60=;
        b=IHXypc1SKmTx4uJsEdXxXWipj6O7IGi92mScLiLsdS82qAXLFByvPcC6Cli08qkYOg
         +yp2KO3PkWheeBIN7QJ3ZSh82PRAPLQ0SjPRGMGyj05uMA/5p2+3u5SP4VJEwN9gnuga
         Au3swx9LiX7CfNkSzGaO+vjLzsYl1wKPdVfSuifpAA6ysarjHKZ0+qR/snxTfII633ep
         gNMkcRP0FJgVFcyWDFzooobo0hOuSJ8LJ7nEmR/nyrZYkpRKFGoHrAKc7R+U051OETEE
         PQbOopLDhY28+Cm923UUYaDSS4f1TwtBTJ1Dw08G9j8f0c5sT3o9GZU/vLWN8BI4MVHH
         +IDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751371418; x=1751976218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u96x1JfBwvgLGiFlKKRmBEu1YqkfwBmaBuctHI0YH60=;
        b=bGsGlqwRqdmpxpsw5SzjVwieIoYotzH7Qa1t7hPFgiq3hmS5EtfuhA1E4mHMjkFGZk
         rVO0sDOd1wTJLbOZZvfz4rvXm2ByR1Bd9IsbfOreq/FEHINDn71+WkAWR3we2h1f/Xua
         sXx5bD/oBF7kjOWNJBij1a8n06eVZYCYd8QQ5RZKgvPtcaQBkYqHSqzwsmMuS7SBfxA4
         Agjs5lAsmd1Z6GzUpMrYFGzhu4fsKI0OvFjHvShW4eV/rLy8xNOy1tB+cH1hRWo4Y37B
         p0vu+Bcg7xj3O5aaH9wMAT7eZhqkf2AiuAf0ciLUGjUpvR8JMLkNDNedAvgpQMDmVEtN
         +EmA==
X-Forwarded-Encrypted: i=1; AJvYcCX2cx1Rt1f7caIM4QzJBF9X8y/Oi4P/p7p8Q14eU6iu779mOWnwe8nl1BFZ6mws6bBd6xzNm+xV3EDhJhA=@vger.kernel.org, AJvYcCX9NkjaCZ5sG05Llcpl0B5IsWMtY9YKAuxfvsTkl3SMWBi3C4bDoFohokTOEvUptkvhmhbFdQiTHCRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOeZj6F0T95cLlmChUxJTfmfTcQYyf7IvNDMv/+4udJ5TTOZ0
	N8poiM/KuslFNqUjeHQy/EIBN/7N5YybD+PBBBS6e3NwvKHLoT0ICSCA
X-Gm-Gg: ASbGncuLk8Vq2XIYuj9hvz5UFr/tBT5gpnVKaXt6/oSZoqwjW2UVJ3KY55fijCOvqkF
	FrdkHm0PYFjxRMK8KIE37ZN5WR+aLFe3Hq50Zl+nrhkJuaU8ft8Nh2BcaRWwQNHx19Yw7TeV9wX
	pjSGnWMq0KTE81hTod80jTZzmTPdho/i1xkNgpDYuB0ZC7Nn3zR5C7t1JPqgWm44bGPUinozltH
	uTcj8Y4gQ9ACkKl76D6y7Zcd9t1OTha+FrV/zMbXVsy8KxjFtBjPo16fkhicEaPD0yiIl9X3gfu
	GAw4giHtTs+Wl0PerZuX9X4e2c/uDDJplegd4y8dhWT1pPzX+Q==
X-Google-Smtp-Source: AGHT+IEqGZkaKeymTeUbc3R0Jer5+f67MSqiVnEtF+k9RaGWT4yLl2LhTIn7tVAVFgdHVrYUcmDoQw==
X-Received: by 2002:a05:620a:4623:b0:7d1:fc53:c6b2 with SMTP id af79cd13be357-7d443974577mr2475688285a.41.1751371418232;
        Tue, 01 Jul 2025 05:03:38 -0700 (PDT)
Received: from geday ([2804:7f2:800b:4f51::dead:c001])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44321a706sm753060185a.81.2025.07.01.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 05:03:37 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:03:31 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rick wertenbroek <rick.wertenbroek@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Valmantas Paliksa <walmis@gmail.com>, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
Message-ID: <aGPOkw2G2IeNhDRy@geday>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
 <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
 <ce0fdbf2753075056c227ce7567a69386a5aa0a3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0fdbf2753075056c227ce7567a69386a5aa0a3.camel@redhat.com>

On Tue, Jul 01, 2025 at 09:54:51AM +0200, Philipp Stanner wrote:
> On Mon, 2025-06-30 at 19:24 -0300, Geraldo Nascimento wrote:
> > Current code uses custom-defined register offsets and bitfields for
> > standard PCIe registers. Change to using standard PCIe defines. Since
> > we are now using standard PCIe defines, drop unused custom-defined
> > ones,
> > which are now referenced from offset at added Capabilities Register.
> 
> This could be phrased a bit more cleanly. At least I don't get exactly
> what "from offset" means. You mean you replace the unused custom ones?
> But if they're unused, why are they even being replaced?

Hi Philipp!

"from offset" means we use standard PCIe defines for registers that are
adjacent to Capabilities Register, and we reference them from the offset
at Capabilities Register.

No, all registers replaced are in use, unused in that context means they
(the custom-defined registers which can be referenced starting from
Capabilities Register address) become unused after the change, only.

> 
> 
> > 
> > Suggested-By: Bjorn Helgaas <bhelgaas@google.com>
> 
> s/By/by

Thanks for the capitalization catch. Unfortunately there's little I can do
now that Mani went ahead and applied the first two patches (directly
related to PCI subsystem).

Thanks,
Geraldo Nascimento

> 
> 
> P.


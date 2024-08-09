Return-Path: <linux-pci+bounces-11526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EB94CAD8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 08:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378192812CF
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2024 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1216CD25;
	Fri,  9 Aug 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icugcXWv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086B16D338;
	Fri,  9 Aug 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723186719; cv=none; b=OGnutdtb8oyqbt3/NSzKGWM8+2JQIUabDWqK7z5JGBJ94CCip59WY0wtEIRS6RtjKQy28wx+GYPffbWuhuyZ5oB9iZV4kCN0HcjawvfpqJpk6I/D0s7zA8HSuJ26wwIn+SfWVjq0B453rV+PT3ldiqMQOjtSCXG0jPlfd9VlTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723186719; c=relaxed/simple;
	bh=+bxn97L5U0jovluQjgn3cx2MdOyOfAmSYZM+tbGjxcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXMQnVH8cpJ4tiUX8F2goVnenIF1S2VdMf6INIDbzijzaIZ8qhkBjK6QtxGPkeS+ISPOgF+RLAq6EIgC7UrE889aHwx2u1ZdfpdA2Pd0vBmAZ1Rbj2vzGbSI89mDM0QpSnXDbPhAUVieQmVQRseNi5MW4KvMGIGlaIeH/uREBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icugcXWv; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6510c0c8e29so16712327b3.0;
        Thu, 08 Aug 2024 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723186717; x=1723791517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bxn97L5U0jovluQjgn3cx2MdOyOfAmSYZM+tbGjxcg=;
        b=icugcXWv+r9/Yc7iF4ApE4N/26tbMs/QhDwOoWtv7UHT6BExKMvweZFVrXDXkxoL3P
         2ks59NLIEF/AMBivwTj37NYZkGIKGDSUSOoS+ppeimgaGNDyrOWu+74ZbZdBBzDwXVI2
         W3dTVWkO05yjOZOLM5r5GQDJ7BYe2oykLk/PfZM1cFQnoGfJ1oWY6sZqlN0HEZFu9xGR
         PF5f2jcwx1LlQpXb4ohkG33v7N+RCXto5DFa9sltrIjR/58hQCQL3uwGr7MUoWiBUkAN
         jdqbGyeZN70YWL935MleAw54QdcznvUDDgwOHAHX4+JS5YA9Hih+F7ywtpzTuMdXeZPn
         r+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723186717; x=1723791517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bxn97L5U0jovluQjgn3cx2MdOyOfAmSYZM+tbGjxcg=;
        b=xDisQ7WGnR50eFho/hIkRdfE8CwteE7j5b70cchfKX9sXXhBtAbI9BD0wGU+C6gsYO
         Q7e2xhXvvM8QAXgyvlOhmXSGXrz/b0WmVIoRd6zzQxho8b0e+0QNbvtwmVGi6vktEdnr
         bEYnG+VVZHl0XEAblIFAqB6pC+Su2UeRxDdM+5Sn8ySWLI58PIs1FPxSj0Uvlp5MilQz
         WV2JBLkuDw9xXIHikRtIoSPAJ7jtqRT3W2X5oJAnyLzt9cs9xL/Gjxc68iDRPNhN5IrD
         RemrH+mvw+9/3jqV1OFjhjaHBS1LgsGNAE79N+8z34EmxH69J1lhP6bhTJzsIe8GaiCo
         QyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUdb5+bV1mFXtGt6XscnI01QZvmYv7hTfbZU79djHls9w8tc1cH+/2ani7R4q/gfiyobCQ3220suqX4WFW0/7oMW6rL09baEkVEtltU3a7verwiOLd1NyjOuXu9cOnNeQCe/6OP3TH
X-Gm-Message-State: AOJu0Yy64//7YqlTosKTxgT9q2qnm0kqTYYYaZ5EvBpSuLzhwlOJqBzm
	fVbNot+x1GkcntKi42wLLW18OQc2SAFzdfcbwdXPt9hgIMk2KbqHZsuoaC9g8OoG7aX7G9Z/l1Z
	vueKfPidKl8tmv21clGVrSwowxjc=
X-Google-Smtp-Source: AGHT+IGCdlIhf/gSlPZiFWzLSwIS6W3p+Q5jsx4eyh8as6SsULfzMey0q4qy5+vvZxORjfzvWv3Eg8Dm3aS7oSC+XsU=
X-Received: by 2002:a05:6902:2683:b0:e0e:b200:a222 with SMTP id
 3f1490d57ef6-e0eb9a18415mr707067276.38.1723186716780; Thu, 08 Aug 2024
 23:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806162756.607002-1-rick.wertenbroek@gmail.com> <7a44e4cb-9f91-47e3-badc-8c6d406d1ea0@kernel.org>
In-Reply-To: <7a44e4cb-9f91-47e3-badc-8c6d406d1ea0@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Fri, 9 Aug 2024 08:58:00 +0200
Message-ID: <CAAEEuho9oyoyGjbWB0qLPEjjC71cnp2hSuzZ=QNQMfaLDodOtA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
To: Damien Le Moal <dlemoal@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:08=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
>
> While at it, can we change this message to be clear, e.g. "DMA not suppor=
ted".
> "Cannot ..." is vague and does not state the reason why it cannot be done=
 :)
>

I can change this, it makes sense to make the message clearer, I'll
add this change to the v2.

Thanks.
Regards,
Rick


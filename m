Return-Path: <linux-pci+bounces-4554-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9249E873291
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A506EB2C975
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD04D5C5F8;
	Wed,  6 Mar 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUGI+jie"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163D014F7F
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716799; cv=none; b=AAO1bWLQohV6GNfz2afM/eNO8BOwUAZmekk+WFO5aIcU+h1cXX0LdrBlLp/W0Q4D45/x1y9UaBp+bvonih1wPcZTgibZv6dEE4KAQduJniZJzUnik3cVkCIDc5C8MFaIXZRvu72cD4IIn1lBShGNMBtaCw80kdLtbqOQQq1NIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716799; c=relaxed/simple;
	bh=wnA4PSgiocDkaO9a9fgbw4GvaFZtLsr3ns0/Zd4EM9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kURnju0crKtqzfYN1HpDK6MIdhdhJT8kZWX26M2WJclLMmn5wzf493H/PozSqxw0uA5ymzhxcKtm6oEKf/roQv2dE5PAY7DRB051ukJdPiEAOtNGZWCHRVqqOc99Bi7IYb1KXfEH56d440nCxl9VwfzQE8ARkNyJCJQCU5H+yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUGI+jie; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6098b9ed2a3so41794457b3.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 01:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709716797; x=1710321597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiSYTBBix3pZDJn7hX0hlhePaaHKbsR/+LCZ9GmLewo=;
        b=gUGI+jieFYCwkisnrcpYvaN1JhmccfRORCE2xKGr8QWipN+Cz/gl2MMHhuYtIW1gIt
         gqDr4W/d18XnBLY6nW85KhlyxMLb11m1X9roYK+KlgGwCF446cjE9VeEGkV/rz0appLJ
         MKrKLRjDLjDz5UzpizsTJWVUNhvpBMU5OZbhJJTlYsfZkNRF2OU7/ax7wQZrDZUoQcys
         sSP7m8gBHJpWLy1ixNieTeRFLiZQTc5hBn7nUecObxXENwTrqoDmRGCON8sD3l6SoDp7
         mJ/0u0ZGjzY6RYHb+ZAZqqQeo4B4aR5esijQmCMz5JN1L+bB/KW+mKDyCZ4b6esXsWkV
         e0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716797; x=1710321597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiSYTBBix3pZDJn7hX0hlhePaaHKbsR/+LCZ9GmLewo=;
        b=KfyT7N9RQN26rwnNCMI2uD2qm+oqwgROhLUi6qHCM05A43WkdP3uTseIYhnxlnvYB+
         ifjYsWw12D0RGdAtNhx2DeS3pbAuU4Uh4jr1rFD8NQYRqxrwjow6IUm+XWQi0iIqUQty
         KZCTizbTwSstqTXljXJpvttU8NlKFm3BlBaTMNxa1H4/jKEjuzx4oQnootC11u4oiqgw
         jW6g3D+jD3wMp/oYOrAiZbEjCTrsXcqEpuN7UHSS3E2JfbrPrjlh5gffEEvlrqDUYIbW
         DV4C3MrOjy9jMLxCEVZFwOYq8tP62GQp45AdjCONhIb6LEVBGLnbmT442EN6pVMZ1QT7
         6aPg==
X-Forwarded-Encrypted: i=1; AJvYcCXO1r3WjIJX4xshJCu7qX+DrZkmVWz+n3AgD7UV/y8psFcYOfn7D7hMRkA9uB2n3svoJtqL9vCIOlZsa9gUNEIoIXOfsVb6ARLk
X-Gm-Message-State: AOJu0Yy6hdoFdirdDdV9hbMUEnqJc2mAM24TFA+Dfjpzmjf98u4fLALu
	VjtvpBMMsp6rPJbcbCM5QTwGd9DFS38zQ6JAbAdKrWMznag/1VTc/A8jNx7KEn+mB8Pawo2QnXz
	nGHKczpUjrJrMGmtWy8kKtfhJmcWw/L17glN1eQ==
X-Google-Smtp-Source: AGHT+IHyeYsmYRCqKOcgrD9TZYmlyF8yBHb/OxI5zro2IrJ1SSYv3q/VJtz9XdZp/Tg8ip3W3ePtZ58gw3pMgY9V8Yw=
X-Received: by 2002:a81:83ce:0:b0:608:4e7a:abc7 with SMTP id
 t197-20020a8183ce000000b006084e7aabc7mr14193190ywf.29.1709716797169; Wed, 06
 Mar 2024 01:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305081105.11912-1-johan+linaro@kernel.org>
 <20240306063302.GA4129@thinkpad> <ZegZMNWxCnLbHDxP@hovoldconsulting.com>
 <20240306083925.GB4129@thinkpad> <CAA8EJppsbX=YXf1Z6Ud+YMnp2XnutN1hcb1T0KdAAWXFREVxXg@mail.gmail.com>
 <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
In-Reply-To: <Zegzf_QKbr8yA6Vw@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 11:19:45 +0200
Message-ID: <CAA8EJprsZz08Otk8hUxu3tQLXen2a3xeW58HLbNSSm=d2OAWkQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3
 ITS enable
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:12, Johan Hovold <johan@kernel.org> wrote:
>
> On Wed, Mar 06, 2024 at 10:48:30AM +0200, Dmitry Baryshkov wrote:
> > On Wed, 6 Mar 2024 at 10:39, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Wed, Mar 06, 2024 at 08:20:16AM +0100, Johan Hovold wrote:
> > > > On Wed, Mar 06, 2024 at 12:03:02PM +0530, Manivannan Sadhasivam wrote:
>
> > > > > Just received confirmation from Qcom that L0s is not supported for any of the
> > > > > PCIe instances in sc8280xp (and its derivatives). Please move the property to
> > > > > SoC dtsi.
>
> > > > Ok, thanks for confirming. But then the devicetree property is not the
> > > > right way to handle this, and we should disable L0s based on the
> > > > compatible string instead.
>
> > > Hmm. I checked further and got the info that there is no change in the IP, but
> > > the PHY sequence is not tuned correctly for L0s (as I suspected earlier). So
> > > there will be AERs when L0s is enabled on any controller instance. And there
> > > will be no updated PHY sequence in the future also for this chipset.
> >
> > Why? If it is a bug in the PHY driver, it should be fixed there
> > instead of adding workarounds.
>
> ASPM L0s is currently broken on these platforms and, as far as I
> understand, both under Windows and Linux. Since Qualcomm hasn't been
> able to come up with the necessary PHY init sequences for these
> platforms yet, I doubt they will suddenly appear in the near future.

I see. Ok, I retract my comment.

>
> So we need to disable L0s for now. If an updated PHY init sequence later
> appears, we can always enable it again.
>
> > > So yeah, let's disable it in the driver instead.
>
> Johan



-- 
With best wishes
Dmitry


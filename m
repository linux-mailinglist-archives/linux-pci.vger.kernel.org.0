Return-Path: <linux-pci+bounces-12769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C659796C38D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 18:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2F2833ED
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB31E00B8;
	Wed,  4 Sep 2024 16:10:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A61E009D;
	Wed,  4 Sep 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466258; cv=none; b=XLHyQVQ2hzDpogUQf1qUSRTUy+z9qlcZtJyPNMpGO5b/eefudlfNIYM4hm9LjBprT05fkPPb0BymqL+JITLw/2TQX7O9XJ9BOSQ3al96iUW9hje2BBhF1WMa2LJop98qNg0kqplL5pp4lRfJ3NEhUrDLC/TgPWb+vRYvwvvruik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466258; c=relaxed/simple;
	bh=XebD5sK+T1MpEqeCovOSyAGyoLq0q9hEdTnIDhHPVm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IveZtzLoDxk1Pg2419NKcIm2s97ZXQvNbgwUUbhnPs6YOlJkp2QFZj86GhwfJs/tXq8gB+0seLrRGk/uC1iIhH6C/tNQUnHMDUHmaW5G9e+9ZDHOrZcBcMtNZvPfhvM66j+Oi2f1NbozAimzJkS7iF2fPxoRKky6T3yaxcPp+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-205909af9b5so23391875ad.3;
        Wed, 04 Sep 2024 09:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725466256; x=1726071056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulWWIkz506G4MCcxeO/o2OeCBtQ3dEwjtlqjKLNb5zU=;
        b=V4aHAxY3aEEvbQiC2jVwj/Ynr+JOLRsOMe0/jucGIh3JtNjgubbInC992zxJux/USW
         UOBTzgMrx9vcZCqpHp/EKelujiEXHlOxONeUyKzeWN5LWAP5eZzbmmRqEG2JV0qT6TLo
         iIs+vmFhgtwDRRuUP+C1u26moJTekVA0jLAv5jxde4z5XTlK3WZ+xRb2PLS9zxJfA3ia
         3rC2x49DUw9zjdAHVfMHksNsLTjMYH8iQFVAZMExsXAFhSxla9uD5VY4p4SryB7QVCrH
         ldKlhcEsk7M3iHYtqhAOfBqDgPQjJnrjQ0ElWe2trFAh4kaIys4MXCyYeTr5/F8GYII/
         GyRw==
X-Forwarded-Encrypted: i=1; AJvYcCVhx1Qv1/qG3mmHtVIB19eIdO0p+kW2Ue5U+H/cYHifpg4IvghaDQIxSHHjsmi0SyBA4NZfKnanvzEH@vger.kernel.org, AJvYcCWVtkXuNlAjbeoTmrINsm6kV149pXN6JchUCKAyw9st+z8QhT05XX+QQnhLK0LYefKQeqtdLgOvLTXd@vger.kernel.org, AJvYcCXQJveHzkfAiIyf5kI2HZRVqy6rn8TdTD0NAqtWgosr9sSECryBER1ofQtRQmxyPjIKIUj0Ly78wYjUyuBG@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEAchkIqxbCipsCV5PdoyVbIG9SgvhDm9pctpLKc9ek+NV4Qa
	4AyaMF552rVoGeiFJ1fZobPgbWmHQ4faWDKGAw9VMvehoOQ4F1kV
X-Google-Smtp-Source: AGHT+IHTWe1QMNcL0j5jcYDzf8fy+jLskTYnyzaqmzwPXo1IqFYKeba0mBTG+0cPpTCwP1g4dxvS6w==
X-Received: by 2002:a17:902:ce8d:b0:205:5582:d650 with SMTP id d9443c01a7336-205842303c4mr135419155ad.52.1725466256266;
        Wed, 04 Sep 2024 09:10:56 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea33e3esm15158165ad.138.2024.09.04.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:10:54 -0700 (PDT)
Date: Thu, 5 Sep 2024 01:10:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Conor Dooley <conor@kernel.org>
Cc: matthew.gerlach@linux.intel.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	joyce.ooi@intel.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: altera: msi: Convert to YAML
Message-ID: <20240904161053.GH3032973@rocinante>
References: <20240717181756.2177553-1-matthew.gerlach@linux.intel.com>
 <20240718-pounce-ferocity-d397d43e3a3f@spud>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718-pounce-ferocity-d397d43e3a3f@spud>

Hello,

[...]
> >> +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    msi0: msi@ff200000 {
> 
> nit: label is not used and should be dropped.

Which bit specifically do you want amended?  I will do it on the branch so
we merge the final version.

	Krzysztof


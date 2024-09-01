Return-Path: <linux-pci+bounces-12570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291129679A5
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9CE92821AB
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C555185B74;
	Sun,  1 Sep 2024 16:46:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2167D185B4B;
	Sun,  1 Sep 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209166; cv=none; b=pqbbyhabfzpdb7qyV+ZAFdEbO04g5jB1sJi3cXW04wyP7LzmdSrA7qKqxWIaWhHbIWxkT6ZJqdpbVJhARUZTQdfLTzAb7jQn/NRxf8U7Rs4dk+JoTVEFbkZmOukCTdhatLoWvabhZ6eoT68vzvg82dtEIE0JCKPCeXkt5oQEoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209166; c=relaxed/simple;
	bh=M/xvThUkbzg+OZO91YHN1e/W8cMI1LxE1kvitCXrg2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrJueOIrDLte8n2FzE0uAikI6nSYyKQXkut3V+Z3dcNf4SltpuPmNZJDer4V7rda6dB6YG7wN8f7UvXW6xtbBLy7FRVZavH/msYqac4BjuoHrIA91waKKVYtGWLAlXop6eLQ4n1x5Yu2zfugMa2XYu3xap9+Pibl4baCoum3FeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-277e4327c99so382975fac.0;
        Sun, 01 Sep 2024 09:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725209164; x=1725813964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9dhgcn6xhJYnKe/+7hD7FWiWrpWTf2ROhMWSyurg90=;
        b=p8scSfBZqZlKVwLownVNX/dfGAJnKd/8uzxRABMw/eF61yylTFjtIjfk8FzCjhR/oc
         lyf+kPlSOlg2RmNQR6LagL7KWfNr4aARZx49DRr8HdmJiynJ8sUXR9DbbfAXxRlCReX8
         S/xueGJsYv9x8Nxx7t9i0PjmsP2pVPzNukEW699Hz6NwBTm3kMYgWYDRFiMaOaH7xAqb
         f5RAEW6grksfm4yVBwrklnQFYe6y3oH2wsz+pogA6x95o2GdmSGYynYjYy0n7dWK1oef
         iRNzFXBFqANVazrvJsod+67iFWz/9DTC0jSwRn0TbpvEoMNao35J/cA0R+qg0u7p4AcI
         uIRw==
X-Forwarded-Encrypted: i=1; AJvYcCV3qQ2u4ozC4WVoPsXMUKXT/9NulRBHbX+cFcDpQPvy7almjSkByGTA9sHkJ3rCyppxRl8LGeACTd44@vger.kernel.org, AJvYcCWCZCZqBa6yeiX7yoJbFhoI+Bn5giAwVRNG7g2KzpthSSih4e0y6K/GI2lsMZNc3DfhCYkhtsAC0RZ1@vger.kernel.org, AJvYcCWGDz7Fc0gATe4fYbuOsiCgrUtahombGdiPPpON+bDMKFnA8yFucEGdTLdQPyuhKJvUZ3rm1F5V7Rg+rlyc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9aqThGN/HeSvJ5vDILTv7GCtMhaBmQoM6+McexdDrMt+UHxZ
	imW9heommBinso/hg3/nJMCPOfRjkmtgkN9mWznsxWgCF7oE2JAc
X-Google-Smtp-Source: AGHT+IEoTDQIeZ/5dis721JPru6mzVN6rtspCYV7KkKbZ7nsRjbEMXoJKEpu1B9NFdZo/q/9ZO47/Q==
X-Received: by 2002:a05:6870:5594:b0:270:4219:68fe with SMTP id 586e51a60fabf-277d032f1bcmr5653927fac.1.1725209164148;
        Sun, 01 Sep 2024 09:46:04 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d8818sm5533353b3a.167.2024.09.01.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:46:03 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:46:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thippeswamy Havalige <thippesw@amd.com>, bhelgaas@google.com,
	lpieralisi@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Message-ID: <20240901164602.GF235729@rocinante>
References: <20240811022345.1178203-1-thippesw@amd.com>
 <20240811022345.1178203-3-thippesw@amd.com>
 <20240830163341.437jztschfrstrrj@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830163341.437jztschfrstrrj@thinkpad>

Hello,

[...]
> > +#include <linux/of_platform.h>
> 
> Looks like this header is not used.

I removed it from the final version, thank you!

	Krzysztof


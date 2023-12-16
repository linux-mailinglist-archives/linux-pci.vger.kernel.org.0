Return-Path: <linux-pci+bounces-1083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD408154C9
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22459286EA0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF07E8;
	Sat, 16 Dec 2023 00:03:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D60F4F1;
	Sat, 16 Dec 2023 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59082c4aadaso840350eaf.0;
        Fri, 15 Dec 2023 16:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684985; x=1703289785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKB/UBddCQ7AEV3E4A2BaNHwCEozFFYyOGvd/xO8jDA=;
        b=rAX/XDUtCamfjCWCFVfD+OrFHCBgm2M3Aj/u1vtMlfL/ctYI/U18x1refVo+KI9OUx
         l7smMB/zqEmrWB4L75F+1wMoM7H4TUWWlFCPdVycFoZUHdP5fMpdc2iKhOpQNzoqQrGg
         i3zR1cdRmI0flRpVL+FnZpz8duXEPTqgcABH+KzAUw2mcu4PxBNvDTYXc1M/507AQP7l
         JlX1UbZj+LIsCFuB5Eq5EXLcqeFa7jRP7rM12AOBtpP9f4nUz8UAxrErz2PlLU+/feW0
         QrylIkVvNIPI3OOA2rv7HFriuHLBKrLLfa92VJfsGo/o7NGPstPt7h3mYldlpSjhkdwC
         oUoQ==
X-Gm-Message-State: AOJu0YwAUKYoWIIpnwvzYZ5OntrkJH2EUmiBWS4kVX4lsEEghMB08X8u
	pjEekPyiHb5YG7wwAYte8Uw=
X-Google-Smtp-Source: AGHT+IHudF6TUPcWKU93i1Vv/J5TfolIvwZLV7BgtvsNekFWmBy2W7f3F3sF1dECv9ecsYa0gZnOWw==
X-Received: by 2002:a05:6358:5920:b0:172:bb4d:919a with SMTP id g32-20020a056358592000b00172bb4d919amr976597rwf.27.1702684985070;
        Fri, 15 Dec 2023 16:03:05 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090ace8e00b0028b415f5faesm536217pju.6.2023.12.15.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:03:04 -0800 (PST)
Date: Sat, 16 Dec 2023 09:03:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Message-ID: <20231216000303.GC1570493@rocinante>
References: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
 <173513e2-d2ec-4932-886a-7c9074633093@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173513e2-d2ec-4932-886a-7c9074633093@linaro.org>

Hello,

> > There is no "resets-names" property, but "reset-names".
[...]
> Krzysztof W., Bjorn H., Lorenzo,
> 
> Can you pick this one via PCI tree?

Done.  Apologies for the delay!

	Krzysztof


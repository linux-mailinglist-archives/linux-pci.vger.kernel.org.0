Return-Path: <linux-pci+bounces-1082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579E8154C5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F921C243E8
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE69A40;
	Sat, 16 Dec 2023 00:02:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809304406;
	Sat, 16 Dec 2023 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-35f3e4ce411so7536055ab.0;
        Fri, 15 Dec 2023 16:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684947; x=1703289747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9i62YdT9dE6duOtlQtMrokuNps6ULf38KYvoR5jIR4=;
        b=Ml6xex67Cq0WrqKu9wvmufnMfKqj8mB6Nz9mYYMWUe3juPIXeJ6qIz5q+XWVDQdScw
         ZoHA6lr+ifl9J1noEeSY0YhWQJOtGn6sY25fdu/NbKO9JEmPUNFh9jGsbQ6sVh7/m3hc
         2C3/P2ZT7TSezkTI5fzIj9xBAn8uLOF5v3QQYuPiOa97dWW3y/mvKzu43Rv42xeBdy2n
         xuwpZOe3oQJE9ek5aejWWQI/ZHs+/HzW4LB97tbAsRqA7qGIqcmQMg4jSZDurfsl16YY
         hQWnbanM8Ae+GYx/JexPknw3v5ygWkcxiQmRpFlW0Q6jMzSM+Tj7uHKlan2u8mZQ5HnR
         VQ6w==
X-Gm-Message-State: AOJu0Yw1FhU73rRJ3Zlg3EBngVMy38YA7vM4nyZ9YZThW2v0Yv2/pNQh
	JB18M/e9Clxt8a+AzuWsMIo=
X-Google-Smtp-Source: AGHT+IEAvclkEwNnk6yOtGocBSwjHeKqsSnI6arQHEKm+zMUxj6bFymJXjMZfTum84wGDMPpXvSsrg==
X-Received: by 2002:a05:6e02:12c3:b0:35f:84b8:c1af with SMTP id i3-20020a056e0212c300b0035f84b8c1afmr3975644ilm.31.1702684947507;
        Fri, 15 Dec 2023 16:02:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001d052d1aaf2sm14658389plh.101.2023.12.15.16.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:02:27 -0800 (PST)
Date: Sat, 16 Dec 2023 09:02:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Correct reset-names property
Message-ID: <20231216000225.GB1570493@rocinante>
References: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111142006.51883-1-krzysztof.kozlowski@linaro.org>

Hello,

> There is no "resets-names" property, but "reset-names".

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: qcom: Correct reset-names property
      https://git.kernel.org/pci/pci/c/3b74713a0321

	Krzysztof


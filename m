Return-Path: <linux-pci+bounces-22077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CCA40638
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813FD3A74EC
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F9204C1E;
	Sat, 22 Feb 2025 08:11:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D251DE4E5;
	Sat, 22 Feb 2025 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740211889; cv=none; b=LeGvnsztiOqy3isQLthvYSTL+TQfo6f6KAr7DIz+0wkQdw7qLYlwW+FWYDTnNqoyhHvnsUHO/bjoktZyQQf9AEm8NEPktW6bYZ2vtyCp6zGZNRO7koyKD7B6TrrhnqsO+Cz4h5ac9Pcr5kCDXyqbq+7wDqPyoi/0md4E1OcjTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740211889; c=relaxed/simple;
	bh=ZOpwXjS9KeIhE21B+gBzXojUKxFIqvEi76/ClH7gJFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl0ceyoZLMNVW/MGZEpyzLmV0ak9GvlAvlXhKDwMf/j/774EeWYF64pUMv0IaqbvL+tP35RoEWNrEm8KoS/KDsniqQJKRcC1h7bScPiNmBTJB2KabNRtXIpXbT6W0atieb7aFC8SDQ2vuPlzw+RAnAfF1sl6uLo/F4YrnrHaCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2211acda7f6so63572595ad.3;
        Sat, 22 Feb 2025 00:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740211887; x=1740816687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/vYTezKRiz0FWfXEhILnceO9ruDUuvvR8Zl89UQ1OY=;
        b=TArXKY8ogEjmLkH0j9s8K6Xk03ycIb1+ngzSreQlbK1BegETeE3e5j7q1RvT0UwVVd
         RzGaSBVzG8L2cG7VbBgbbGsLNYCu4RHRpz32lIxxjAjarPY/Zw1N/JBsNr3z5BKRNmyB
         bhcOPutasXMkIJdqmjq2bTuuC0sleMidBERLpgCM0guB3KaJsJQs9S95737JdzEwqPmH
         tRijrKr/As7bv/W0wKY/skscq/sLv4TZGlQeYa45MbhA4MqPTc/sTzKWpq2g197ovsGX
         xe8YwXI5Kr5Pb0vMOKKZKNuAWiDsXnpgc5MwrmcmWOVH8vKooPtYyPn6sth8vd+udBNA
         zxGg==
X-Forwarded-Encrypted: i=1; AJvYcCUITD9w1BZBWZjaoNlTYkjpvUISB/HDLufL/MCK0zY7jcxzwux3idtT68vnkvFVETvK1yZ0ayT0uhs9@vger.kernel.org, AJvYcCUpkY9EKIp9Xec2EqYSxhYLDdJKVwQdqpb1guobP0w4hxzDqugiOzfC1I6xTOFUumEw+snhYYEUwVCN@vger.kernel.org, AJvYcCXzY808bRkuMbusQXE7dRl+F7UIijxg/7Dss+hbA9YFE1xREig20h6AB/347i5kXhke7Ie0W3hCeLBAfpCF@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQM5/x0RycQIXkBctUQPA6esRhL13vbfjFA0dvyQct/aHRaUW
	AJVQGfFd4U42goBhEomEfQqKkoHREfphFfI6iGokqpiFzVDjPyCqwRlo4uMZ
X-Gm-Gg: ASbGnct3kEfKg58ZwaLqziI3xCWXwD7ft1O2YXV+t4KDcG1kvLFn1JC8sMCHwdOXEG4
	rc/w5lcFTCUm9rVfj0LH2/am/EkmCGS2i6SiN7ZgMd2PK3zJnItDYwACYY/KxKPT78LbbuvfiL3
	v7sgpmk8gmU71vNEel5z6vNNZJB3aRjRUted+0Yd8qPKhwTzNzW1Jhbo1CxlND39FdGTkORj8Sn
	oG31sdRuMna+/2uDUPxxy80fGCcUYV8diDBXDVdBy464EeFxPSWYSUzAT2+GxOfCDn3UzfC8L3v
	KmPnUK9mcJRiW/E4Tla5mKuFoVFRaXNXjmo/S2rNWdoWf5cJSBaTPS7tnFB7
X-Google-Smtp-Source: AGHT+IF7FXrvfwa9/zGSAfB1z2DwXRu20PoXhBh4tgOozFuik5hPpvLwKCt3cLxdgEq93hZB8iQhkQ==
X-Received: by 2002:a05:6a00:c92:b0:732:1840:8389 with SMTP id d2e1a72fcca58-73426aeb741mr8918405b3a.0.1740211887503;
        Sat, 22 Feb 2025 00:11:27 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73271a02648sm12317180b3a.107.2025.02.22.00.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 00:11:26 -0800 (PST)
Date: Sat, 22 Feb 2025 17:11:25 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: j.ne@posteo.net
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: pci: Convert fsl,mpc83xx-pcie to YAML
Message-ID: <20250222081125.GD1158377@rocinante>
References: <20250220-ppcyaml-pci-v3-1-ca94a4f62a85@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-ppcyaml-pci-v3-1-ca94a4f62a85@posteo.net>

Hello,

> Formalise the binding for the PCI controllers in the Freescale MPC8xxx
> chip family. Information about PCI-X-specific properties was taken from
> fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
> xpedite5200_xmon.dts.

Applied to dt-bindings, thank you!

	Krzysztof


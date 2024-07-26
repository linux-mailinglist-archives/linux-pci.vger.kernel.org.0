Return-Path: <linux-pci+bounces-10847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A878993D7D4
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13714283BD6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BC17C7D7;
	Fri, 26 Jul 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAQh8Rs8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07E17C7CF;
	Fri, 26 Jul 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016381; cv=none; b=n4hiQZiFISouNQKYR3HbG3v46iCNns4z8W4CF/BoqpTb2AaPfyIBGE6PgMVPRW6Zuzuq8poKFb0LIsqMD+Xg3uy41BbqOW2/vJ6T9j9mU4y2RmOuMvISYNXs9YSLaW5p7SwAlkRB+shdznjUEjMNp9oi6fVqnvhYUWXR0lQvI30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016381; c=relaxed/simple;
	bh=gbriWgUniQV5sMUGUpc7uG99BGb3pVKbc+1MWsqJxl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE6qn3bSLV0GC6OV1EmH0jS3N4bO8AQiDlA33tUi+R53UMKJ3kunolWxOUTabSu7H8uU9vtmAmlfshiHKB047KhdqB5QUOfsAO0NUySYoH5S8gSAg6rZE8FuXTNzhXkrbGKrKkhAD4DqPi4B60B/rJ1T2f+R7EvQ7HRIQ3RHfKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAQh8Rs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAC7C32782;
	Fri, 26 Jul 2024 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722016381;
	bh=gbriWgUniQV5sMUGUpc7uG99BGb3pVKbc+1MWsqJxl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VAQh8Rs86BVc0bQxBQpsw7E3oB7YUvEzDioyvNYyYRWg3/YE7BJZ9Bb5yeZktWUpE
	 1jI2lNv0JjHBTeMrqFoOx4732CF0GlVQ8ls/qKpBs5EaMagA0+TzO3hURk91b+c2nJ
	 GYh/ZaOkeTJ/Ehvehu29zHCbM1rfeyyShv0iZfQnHzViqUZtSQh7WwhFsgBPAwKaaR
	 nXKjVlm1GJwtqXN4zJMB6FcsT14q3jUJG4IAHR0gTYtnyeAzTexMgGLCGw3OqNya4Y
	 gHCfIMUscJ9mctMB6SDLSpL1yVxgIEmLbOAyZax3r6DQVedli9R+6goBy+Yf/JOwlD
	 YhO2AP739onfg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso22825781fa.0;
        Fri, 26 Jul 2024 10:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrsVPzPygjIKRSXvxldVLhsgDZ1wWrePEaktv6iuCfZkgR8IOsVkkD3ubu1EvUjwYDyLSku+2H5lbS941ejyByE2fYCCm0HR7a7IgZClId9VQ5axIR3x2Bbb2gkIqGwQgfHGRjutTEa6fJg0vwDkJmBVxJoR3/R/Wf0GIkAxwx1hE=
X-Gm-Message-State: AOJu0YwOV0vHjL9EaHuV4O/3uqHs+KDvdwDGhncAp0QXY0QWnuSbh5ph
	ZKBggRmt0lpf2mw7FO7mCzy1T5z8dKc3QXzkUaJRaA217EytR4VapUci2TymQJKMagA0XKYz7Id
	iC1WcR0bXmIuIxzigZ5C2mu4j+A==
X-Google-Smtp-Source: AGHT+IGIboFhjpqofVqlOelOMvR4+RrtFqzfu/57gAtHLJz3rx7lzmCVwhoRpixh1COmKEuQcel3sDSsZgJ8oYzdKa4=
X-Received: by 2002:a05:651c:a09:b0:2ef:2d54:f590 with SMTP id
 38308e7fff4ca-2f12ee278bamr4650001fa.24.1722016379634; Fri, 26 Jul 2024
 10:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715080726.2496198-1-amachhiw@linux.ibm.com>
 <CAL_JsqKKkcXDJ2nz98WNCvsSFzzc3dVXVnxMCntFXsCP=MeKsA@mail.gmail.com>
 <a6c92c73-13fb-8e9c-29de-1437654c3880@amd.com> <20240723162107.GA501469-robh@kernel.org>
 <a8d2e310-9446-6cfa-fe00-4ef83cdb6590@amd.com> <CAL_JsqJjhaLFm9jiswJTfi4yZFYGKJUdC+HV662RLWEkJjxACw@mail.gmail.com>
 <ac3aeec4-70fc-cd9e-498c-acab0b218d9b@amd.com> <p6cs4fxzistpyqkc5bv2sb76inrw7fterocdcu3snnyjpqydbr@thxna6v2umrl>
 <d20b78cd-ed34-3e5a-0176-c20ee5afd0db@amd.com>
In-Reply-To: <d20b78cd-ed34-3e5a-0176-c20ee5afd0db@amd.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Jul 2024 12:52:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJAuVexFAz6gWWuTtX1Go-FnHe6vJapv0znHBERSCtv+Q@mail.gmail.com>
Message-ID: <CAL_JsqJAuVexFAz6gWWuTtX1Go-FnHe6vJapv0znHBERSCtv+Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix crash during pci_dev hot-unplug on pseries
 KVM guest
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-ppc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, Kowshik Jois B S <kowsjois@linux.ibm.com>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:06=E2=80=AFPM Lizhi Hou <lizhi.hou@amd.com> wrote=
:
>
> Hi Amit,
>
>
> I try to follow the option which add a OF flag. If Rob is ok with this,
> I would suggest to use it instead of V1 patch
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index dda6092e6d3a..a401ed0463d9 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -382,6 +382,11 @@ void of_node_release(struct kobject *kobj)
>                                 __func__, node);
>          }
>
> +       if (of_node_check_flag(node, OF_CREATED_WITH_CSET)) {
> +               of_changeset_revert(node->data);
> +               of_changeset_destroy(node->data);
> +       }

What happens if multiple nodes are created in the changeset?

> +
>          if (node->child)
>                  pr_err("ERROR: %s() unexpected children for %pOF/%s\n",
>                          __func__, node->parent, node->full_name);
> @@ -507,6 +512,7 @@ struct device_node *of_changeset_create_node(struct
> of_changeset *ocs,
>          np =3D __of_node_dup(NULL, full_name);
>          if (!np)
>                  return NULL;
> +       of_node_set_flag(np, OF_CREATED_WITH_CSET);

This should be set where the data ptr is set.

Rob


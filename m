Return-Path: <linux-pci+bounces-24885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46847A73E3A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 19:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB833BACB7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DB21ADB0;
	Thu, 27 Mar 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ1q1wZu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE41C5D44;
	Thu, 27 Mar 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101882; cv=none; b=L5CaC8MJGxA+92YNkdQqFCTdNxtmHm8Gu9CB3o8OXcjCQJkkSuxOpHzDzdyrQQJvWRmS5Xw0Kn/X+JaPFoqOYPP9unYPsgrf2zdNeaYIaeOezb/3RNg5w5sqK0D7PIiERC2pZH97I9k7U7LOlhbR/kjx7R9NQnZpuc8wXFYPn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101882; c=relaxed/simple;
	bh=NCRgSlQwiTeN8gTk1gYPpD6+NtqKakLmbR8E4o+Ga3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tw8XmF/Yr+dMf75Gzt8/2X5SMGb9wQsnHnDBi9D7VLh6bCvJDsWC/H+d1m+/bMbbHEnoNprImdiiOQGM6OmBL4iKVD9FUO7XBxMfYfdUV+uIzeZvoycYMk7DNERbECID0tS5vdyL65aLQ6AJpGkx2ga6U0N571+LPq5fbl0xlrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ1q1wZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0918C4CEE5;
	Thu, 27 Mar 2025 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101881;
	bh=NCRgSlQwiTeN8gTk1gYPpD6+NtqKakLmbR8E4o+Ga3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJ1q1wZuQ9iz9n544qCGhY7nAYiEdWN8bufMkmbmn2NSTuJz9pIqYy6X6khzKWo51
	 92dD2fdBWguyo2H+9J4/wM0ViHVsA9t2KqShsOms8p1v0utWF4HbOjS3t4/7a1g3mq
	 iosY3vvg8r8nYgRsD9PvR/qcPLMfoHqqN4RT/qVP3xjUBXrilNKgDRATmxWgfAJ2oX
	 fEcUlTK7ReTjqnEmcNGngD+UxFCQrrsskhA1EBNjm+UF05QNkBxV8fS13+Hye+lwef
	 mP+vxD0zxNP7N9YI4HIgJ6UxAG64mkqM7QgE4EzwHlsuui/x8O5gj4x4Jm//bWjJ75
	 8dXivYyJEGRbA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c77f0136e9so393672fac.3;
        Thu, 27 Mar 2025 11:58:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9vkC7WX5a/lguvcoKkjkqNezn+7syDJBRg9CiATwsRmvn1vdhsLhA7hQ7EPWJtR/LTlbl7xrI9l4j@vger.kernel.org, AJvYcCUvImwkj+DbLB57Uh2oMNe2QrkVvf/dlXTLzM+srRd1Nb/kKgKL71/0XILf2F7n32Ubu83UxKDGK8TwsYO0@vger.kernel.org, AJvYcCWtjxX37zLJ5BqiC/q1hv07L7wMpYAuHTlxpVsnBlha2XBCTFmH1OCuSwimWTurmn56lbRmICYwRxZn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5n8WjqtPkn+so9ylbEBhoe81U3eC7osdWHCaJFWMIy2+Guh/A
	ST7zboUf+S9KKk1LDmd+l6wMUPpcEIyWvF0oaZk+HQ2p4DmfeBSnzvuhhNZOQD5ZtzunTpUQTRo
	a7z90vrCEbaEtSCG26MyBn1mtRFk=
X-Google-Smtp-Source: AGHT+IHYW2ZTnoKkUTlzbiUwZcIeb1IO+JEoeqODsoDJB/s8N43IeFO6nFa7Oes6d62s9LbY8f2hVLzaHXcM+PQPbbw=
X-Received: by 2002:a05:6870:b85:b0:2c2:416e:cf43 with SMTP id
 586e51a60fabf-2c847fad778mr2816156fac.12.1743101881047; Thu, 27 Mar 2025
 11:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313100658.15805-1-zhoushengqing@ttyinfo.com>
In-Reply-To: <20250313100658.15805-1-zhoushengqing@ttyinfo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 19:57:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jBrTuuf_RJ45Eu2OwpRNXS-hFyL-PxGMv2K+jYVQtn2w@mail.gmail.com>
X-Gm-Features: AQ5f1Jp1J_eN6hewA6UUzyBXH_BVl2jaLQ_7gV07nxC_OS-JOnVwRvNKQ-vuaFs
Message-ID: <CAJZ5v0jBrTuuf_RJ45Eu2OwpRNXS-hFyL-PxGMv2K+jYVQtn2w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Add rev 2 check for PRESERVE_BOOT_CONFIG function
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:07=E2=80=AFAM Zhou Shengqing
<zhoushengqing@ttyinfo.com> wrote:
>
> Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2=
.
>
> And add acpi_check_dsm() for DSM_PCI_PRESERVE_BOOT_CONFIG.
>
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>
> ---
> v5:follow Bjorn advice, add acpi_check_dsm for PCI _DSM.
> v4:Initialize *obj to NULL.
> v3:try revision id 1 first, then try revision id 2.
> v2:add Fixes tag.
>
> Fixes: 9d7d5db8e78e ("PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to p=
ci_re")
> ---
>  drivers/pci/pci-acpi.c | 43 ++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..4f9e0548c96d 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -122,24 +122,43 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle=
 handle)
>
>  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
>  {
> -       if (ACPI_HANDLE(&host_bridge->dev)) {
> -               union acpi_object *obj;
> +       bool rc =3D false;
> +       union acpi_object *obj;

+ u64 rev;

>
> -               /*
> -                * Evaluate the "PCI Boot Configuration" _DSM Function.  =
If it
> -                * exists and returns 0, we must preserve any PCI resourc=
e
> -                * assignments made by firmware for this host bridge.
> -                */
> +       if (!ACPI_HANDLE(&host_bridge->dev))
> +               return false;
> +
> +       /*
> +        * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> +        * exists and returns 0, we must preserve any PCI resource
> +        * assignments made by firmware for this host bridge.
> +        *
> +        * Per PCI Firmware r3.2, released Jan 26, 2015,
> +        * DSM_PCI_PRESERVE_BOOT_CONFIG Revision ID is 1. But PCI Firmwar=
e r3.3,
> +        * released Jan 20, 2021, changed sec 4.6.5 to say
> +        * "lowest valid Revision ID value: 2". So check rev 1 first, the=
n rev 2.
> +        */

+         for (rev =3D 1; rev <=3D 2; rev++) {
+                 if (!acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
&pci_acpi_dsm_guid,
+                                   rev, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG))=
)
+                         continue;
+
+                obj =3D
acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge->dev), ,
&pci_acpi_dsm_guid,
+                                  rev, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG));
+                if (obj && obj->integer.value =3D=3D 0)
+                        rc =3D true;
+
+                ACPI_FREE(obj);
+
+                if (rc)
+                       return true;
+         }
+
+         return false;

would achieve the same with fewer lines of code and less code
duplication if I'm not mistaken.

> +       if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
> +                               &pci_acpi_dsm_guid, 1, BIT(DSM_PCI_PRESER=
VE_BOOT_CONFIG))) {
>                 obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge-=
>dev),
> -                                             &pci_acpi_dsm_guid,
> -                                             1, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
> -                                             NULL, ACPI_TYPE_INTEGER);
> +                                               &pci_acpi_dsm_guid,
> +                                               1, DSM_PCI_PRESERVE_BOOT_=
CONFIG,
> +                                               NULL, ACPI_TYPE_INTEGER);
>                 if (obj && obj->integer.value =3D=3D 0)
> -                       return true;
> +                       rc =3D true;
> +               ACPI_FREE(obj);
> +       } else if (acpi_check_dsm(ACPI_HANDLE(&host_bridge->dev),
> +                                       &pci_acpi_dsm_guid, 2, BIT(DSM_PC=
I_PRESERVE_BOOT_CONFIG))) {
> +               obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge-=
>dev),
> +                                               &pci_acpi_dsm_guid,
> +                                               2, DSM_PCI_PRESERVE_BOOT_=
CONFIG,
> +                                               NULL, ACPI_TYPE_INTEGER);
> +               if (obj && obj->integer.value =3D=3D 0)
> +                       rc =3D true;
>                 ACPI_FREE(obj);
>         }
>
> -       return false;
> +       return rc;
>  }
>
>  /* _HPX PCI Setting Record (Type 0); same as _HPP */
> --


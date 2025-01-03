Return-Path: <linux-pci+bounces-19193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE58A0028C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 02:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629633A3908
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 01:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612F148FE6;
	Fri,  3 Jan 2025 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECxfB5RL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3313EA93D
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869245; cv=none; b=ATmwCQiVMfSvYQUP6VfXMb0CPZMGc+cDorpykEkDRYjENKunCSOCSY4BLH4q0sqmUQ18y6e+Dmkeyw8Yf2L87MlKqVzatjp5cWfq3gcDsxnJPmA2Oonxqi5gRP01AoWfCGYYFULgh5SQv3XxC2ANXWXhprweR3iSKVY7qk9P8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869245; c=relaxed/simple;
	bh=KFPzrRxSun4CqyFFe7crv0yYjsdP/kWh2W+jLI7+5eU=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iZrhOx/M/BJFegUK/yfXKedgEhU/NwZhw+v40ZmAmT7FW1IvvsxzNFbiq0xX3h8vp56dbpXdKbwj/GOezmr6ojGkiSZTFYjLIjfcUho5yoecKWmtezVy01vUCIAXEM2w3JyxIYVmWqOIcAdh+jJeBRNNKFN7roOh3DYm+ZQoagU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECxfB5RL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46677ef6910so127226661cf.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 17:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869243; x=1736474043; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M56tZOnpBYnCRpoAFoXevxc7oyfOzK3becRET5ZsSI=;
        b=ECxfB5RLYb7W3lLoNHGSqhXsIDqIHL2SbbllamqQLUB87a7eqU9OHBMS4b8DEjcVtq
         8oumT0h8If+Oqvj6RpCVYLCl4BfAaOclpYT5JjneP57/ahqb5BlMGbBC8JKkZ3rx5Rg8
         qk4ljMTk4NwD5576vl4ZP4jdfgBs/P1kQDKCAfIYBviMw5076dXpCVtdXncwN0MIAZvY
         cWie9phYM67QNL+yVbBDSPfPuSGH1a2msC9EadEcELu8DmxSy4sTFJ9bMphSR+cAqb+C
         OH+IbeyZtA8y3P+j/3LsO7EPhGhUp1SR8d9S2iPttYPZpVCdQ8U332EMAC8KMs0Xkn0Z
         Lh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869243; x=1736474043;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M56tZOnpBYnCRpoAFoXevxc7oyfOzK3becRET5ZsSI=;
        b=cLKjDdWouchGQYFIXRKO2gSNIk0QDEVNOqkALLfmpHsVCJdY8Yxi+V0Iv95hCNmRR7
         me3WaAuZPKKcSM0Eh/H/BkMhTHfY1x8ebnNbcKtqNtIblJiqhT5kKnpT8/S3+5FlY55O
         za2Ms/TfPIYO+9COcK9tzc3OU38kvL9WxZmbmrwvz1K+/0c2N6Pr67EmPEN4Md46gAOr
         X4JlZIJuYAsrGHx6ADwMaNZp4M5cBFf4uwm4CPbpu1sXn+o2AzW708+aUPvoOJiwZ6SD
         lGCPyg9jugOdPk9muI6zkPDN37Y1uZNDXTp6wis2du29KW0ZS+DTI0H/e89KGsi2LJ16
         toww==
X-Forwarded-Encrypted: i=1; AJvYcCV6reErzJjXxWwbdrQsQn/HZHyG9cAcUELDJFmoJgllK6X7TaSDxSFwDr6KHpwdJdR1DYx7ySuKDu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqcdRHxHI7jymy+axPDqx5bEh4c0M2IqGFbrAIdogsIOuqnmuK
	yeXhkCHvYeFJV3cHUg5l4fTckIOUWzYtUb3GdZ8V/EkndOVnU9HU
X-Gm-Gg: ASbGncveFyG1bIoiZXvkOUlzY4tx3/fBtT2KlK160JzG2wN1gji6HdD05/kKAKLbwrw
	nkWWgNNvKrk8QTcRYjJK9PJjj4cdu7tDQvr9clDH3L7AXCa7GL05DqlqVSDBQIjOeCTtOiK4T6b
	Vl+w25354dOiulIwkwLFwuMLP0OPwG3W30DdnoyGlVqUoR1sSIxYg3PF1dvfaZQ8nevdBl14z32
	fGiSWH1662aZCXNl89Mm8JuJJ3h5GA9WI+9WWvjk9RZILxWlMaGzHDQeDCxiz9AtzgGfsCDPczM
	7Jrfi1lUun6vkx7SrVAgdaKmmo/kPrcXpd8H9Q==
X-Google-Smtp-Source: AGHT+IHBa258agoCI+TvQMHOxshC6JJj8bFzTqytAq3/8K9obXTuyYKJxqYFVfkUooIV7yZxE+W6Tg==
X-Received: by 2002:ac8:7d46:0:b0:466:9bc4:578 with SMTP id d75a77b69052e-46a4a8e2899mr775177191cf.22.1735869242790;
        Thu, 02 Jan 2025 17:54:02 -0800 (PST)
Received: from smtpclient.apple (76-10-188-40.dsl.teksavvy.com. [76.10.188.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd182082f0sm136958276d6.129.2025.01.02.17.54.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 17:54:02 -0800 (PST)
From: Daniel Stodden <daniel.stodden@gmail.com>
X-Google-Original-From: Daniel Stodden <Daniel.Stodden@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH 1/1] PCI/ASPM: fix link state exit during switch upstream
 function removal.
In-Reply-To: <e12898835f25234561c9d7de4435590d957b85d9.1734924854.git.dns@arista.com>
Date: Thu, 2 Jan 2025 17:53:49 -0800
Cc: dinghui@sangfor.com.cn,
 Bjorn Helgaas <bhelgaas@google.com>,
 david.e.box@linux.intel.com,
 kai.heng.feng@canonical.com,
 linux-pci@vger.kernel.org,
 michael.a.bottini@linux.intel.com,
 qinzongquan@sangfor.com.cn,
 rajatja@google.com,
 refactormyself@gmail.com,
 sathyanarayanan.kuppuswamy@linux.intel.com,
 vidyas@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D15363DF-76B4-4CFC-954D-72A1AB621B08@gmail.com>
References: <20230507034057.20970-1-dinghui@sangfor.com.cn>
 <cover.1734924854.git.dns@arista.com>
 <e12898835f25234561c9d7de4435590d957b85d9.1734924854.git.dns@arista.com>
To: Daniel Stodden <dns@arista.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)



> On Dec 22, 2024, at 7:39=E2=80=AFPM, Daniel Stodden <dns@arista.com> =
wrote:
>=20
> From: Daniel Stodden <daniel.stodden@gmail.com>

If this gets accepted =E2=80=94 remove that line? Not important, but I =
don=E2=80=99t know how it got there. Might be because I had to =
export/import patches between private and corporate machines during test =
a few times.

Thanks,
Daniel

> Before change 456d8aa37d0f "Disable ASPM on MFD function removal to
> avoid use-after-free", we would free the ASPM link only after the last
> function on the bus pertaining to the given link was removed.
>=20
> That was too late. If function 0 is removed before sibling function,
> link->downstream would point to free'd memory after.
>=20
> After above change, we freed the ASPM parent link state upon any
> function removal on the bus pertaining to a given link.
>=20
> That is too early. If the link is to a PCIe switch with MFD on the
> upstream port, then removing functions other than 0 first would free a
> link which still remains parent_link to the remaining downstream
> ports.
>=20
> The resulting GPFs are especially frequent during hot-unplug, because
> pciehp removes devices on the link bus in reverse order.
>=20
> On that switch, function 0 is the virtual P2P bridge to the internal
> bus. Free exactly when function 0 is removed -- before the parent link
> is obsolete, but after all subordinate links are gone.
>=20
> Fixes: 456d8aa37d0f ("PCI/ASPM: Disable ASPM on MFD function removal =
to avoid use-after-free")
> Signed-off-by: Daniel Stodden <dns@arista.com>
> ---
> drivers/pci/pcie/aspm.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e0bc90597dca..8ae7c75b408c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1273,16 +1273,16 @@ void pcie_aspm_exit_link_state(struct pci_dev =
*pdev)
> parent_link =3D link->parent;
>=20
> /*
> - * link->downstream is a pointer to the pci_dev of function 0.  If
> - * we remove that function, the pci_dev is about to be deallocated,
> - * so we can't use link->downstream again.  Free the link state to
> - * avoid this.
> + * Free the parent link state, no later than function 0 (i.e.
> + * link->downstream) being removed.
> *
> - * If we're removing a non-0 function, it's possible we could
> - * retain the link state, but PCIe r6.0, sec 7.5.3.7, recommends
> - * programming the same ASPM Control value for all functions of
> - * multi-function devices, so disable ASPM for all of them.
> + * Do not free free the link state any earlier. If function 0
> + * is a switch upstream port, this link state is parent_link
> + * to all subordinate ones.
> */
> + if (pdev !=3D link->downstream)
> + goto out;
> +
> pcie_config_aspm_link(link, 0);
> list_del(&link->sibling);
> free_link_state(link);
> @@ -1293,6 +1293,7 @@ void pcie_aspm_exit_link_state(struct pci_dev =
*pdev)
> pcie_config_aspm_path(parent_link);
> }
>=20
> + out:
> mutex_unlock(&aspm_lock);
> up_read(&pci_bus_sem);
> }
> --=20
> 2.47.0
>=20



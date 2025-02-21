Return-Path: <linux-pci+bounces-21939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DFFA3E907
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 01:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEFF1895241
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D319DA50;
	Fri, 21 Feb 2025 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yDlTdx2F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AA15A8
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740096589; cv=none; b=Khw+TzLLJg3nn3oJv/H/B99NeuCt1obccLnYK969fp/k/86D9LOGPB5ZdmpnCmauUwM/j1J2C/y/p7iCuc714KUJCu/QX+mqXm+NmT6MT6RvuW6DJH6OMUrFlULq2XQCbnx/t1kbiK20NRNwvon1BURkBLclEehYjynLzOyhUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740096589; c=relaxed/simple;
	bh=CYy+syz0H0mvkNkZkdp17FYvvZqZEB3HFIsP6QAgNM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DQR+8MDzpG07DBVtRawupHCFMGSKL0Wt19XitXc1TOeoCOhaJMsIMU8Who6IeDC71rDllbgN7arCz+CWayyEpuhLWjGW9LNHQGCXLWFzvIn/5robeYkx1+cIuk5BiqeKz5FVgw8CTZFpuC3NQ3dTgJYRbI9Ii8i+UdX0guRFArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yDlTdx2F; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jperaza.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so3285077a91.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740096587; x=1740701387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohok8GBBY7t0QEOt/byU++Ad3TOaqSbLlb97J7pTKzY=;
        b=yDlTdx2FU9/pTlOYk9AlZMCdAzzzK1vy3WUnutiZBnnNP2ixmbc8Y5XxE1wZ3XNLC9
         +Ad24NUDZ4KYWUGQzpaX/qHhVT+7GduoVe8Gwsp+VE+VszSqoT/zuIOwhkmtp4oSNLmx
         9N4NM4h9DHsejNmSCx5Dt/Xy191apGGsgC7olZEThJTwukYRTc3U17rzoeBpJKUBStmV
         je6xfmYppnyoPVGg1owJlSYPZi/6wjcQ1P5+B74sFhSMtF6InMuW5AvXDq2oHNpBwgoD
         erp5HHeanaTGREy3mB/eR+AdW4S0Aj7tTZk9YLnmDfz+f0PojW3T8s+ExKAS55744TUY
         5O0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740096587; x=1740701387;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohok8GBBY7t0QEOt/byU++Ad3TOaqSbLlb97J7pTKzY=;
        b=R3TCkmfptdvMLVsmBkhJeMZtFC4KlT5FPZnXlXICuIUqAqDChRmtC5le2C3rw72+UO
         YIalTc6HF6riD+t6w1PJjSvqDRoty3+O58JMQWPhJCxtQm4pEx74lA05BsAwvPl1qJbp
         arabbie8/o43lzgnTv5jqgudfAkuQqstgV7GujEcBROno8xBrbOZMX7wk2qA930j0r+7
         5CsftYKeleFGQAoyeVp74DkMm84TuGDc2mX/gRkhuznjTeFRZiTaqBAkiRLo/f1VGVV5
         TaYDj3nixKBqGP4vU7gxvNXgLkE68TPih/q6G2v6xVg7NriFeto2PVXKHPK5kFt6iF9V
         E2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV7zFSR1IokaYh0Zi70ImfvFBd/G8eFjo0Pd0lRR/G2Nt03FJWirtZFAR6gn9xRDoqUp031unQfCSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOcr+lyElgAWz2BKc87LWskHP5BWSXVdH74mwWpiOuf82BbnL
	LJqj2UAqfcTmxLsjOuiWdsFQTbfQxJTbJ6lpcimaqEYk7/VLeFx0rjtJIbXqNRzuPxElaTt/uJG
	gNLGB6g==
X-Google-Smtp-Source: AGHT+IE+/XdpryHAXtWsVuqH/GBAd4U+y5+ZwkF9rtofcQmDPCXCP0K1uOrOC/YoiJt7j7ujhepPRibIQz/U
X-Received: from pjbqi16.prod.google.com ([2002:a17:90b:2750:b0:2fc:2f33:e07d])
 (user=jperaza job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c4:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-2fce7b44472mr2063542a91.33.1740096587389; Thu, 20
 Feb 2025 16:09:47 -0800 (PST)
Date: Fri, 21 Feb 2025 00:09:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250221000943.973221-1-jperaza@google.com>
Subject: [v9 PATCH 0/2] PCI/ACPI: Support Microsoft's "DmaProperty"
From: Joshua Peraza <jperaza@google.com>
To: gregkh@linuxfoundation.org
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com, 
	dwmw2@infradead.org, helgaas@kernel.org, iommu@lists.linux-foundation.org, 
	jean-philippe@linaro.org, joro@8bytes.org, jperaza@google.com, 
	jsbarnes@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	mika.westerberg@linux.intel.com, oohall@gmail.com, pavel@denx.de, 
	rafael.j.wysocki@intel.com, rafael@kernel.org, rajatja@google.com, 
	rajatxjain@gmail.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Threat model: An overview of the security implications of non-strict
IOMMU is presented at [1]. This change is motivated by =E2=80=9CCase 1=E2=
=80=9D where
a DMA-capable device is processing untrusted inputs, e.g. network
devices.

This patchset proposes using =E2=80=9CDMA protection=E2=80=9D to mitigate t=
hese risks.
This has the following effects, currently controlled by the
=E2=80=9Cpci_dev::untrusted=E2=80=9D flag.

- Separate IOMMU DMA domains
- Use of SWIOTLB if CONFIG_SWIOTLB
- Disables quirks in Intel IOMMU
- Disables Address Translation Services

The =E2=80=9Cuntrusted=E2=80=9D flag was introduced in 2018 in [2]. The mot=
ivation for
that change was to enable using IOMMU to protect against DMA attacks
from externally facing devices such as thunderbolt ports. The patchset
introduces the =E2=80=9Cuntrusted=E2=80=9D flag which =E2=80=9Cis supposed =
to cover various
PCIe devices that may be used to conduct DMA attacks.=E2=80=9D The patchset
originally proposes naming the flag =E2=80=9Cis_external=E2=80=9D but is re=
named to
=E2=80=9Cis_untrusted=E2=80=9D and then =E2=80=9Cuntrusted=E2=80=9D supposi=
ng that it could apply to
more than just externally facing thunderbolt devices. The fact that
=E2=80=9CExternalFacingPort=E2=80=9D is not part of any standard is called =
out during
review but also that Windows expecting firmware to identify external
facing ports makes it =E2=80=9Cas good as a formal standard in the Windows
world.=E2=80=9D

This current patch series was first proposed in January 2022 [3]. It
originally proposed a new property =E2=80=9CUntrustedDevice=E2=80=9D which =
would cause
the untrusted flag to be set. In V1 Greg questions whether the new
property is part of the ACPI standard and asks who is making this
policy decision. Mika links to Microsoft's documentation of
=E2=80=9CDmaProperty=E2=80=9D and suggests that property should be adopted =
instead.
Greg objects that Linux does not have =E2=80=9Cdma protection=E2=80=9D but =
Mika says
that this is the IOMMU. Today, the term =E2=80=9CDMA protection=E2=80=9D is=
 used in
thunderbolt driver code with the same meaning and in an Intel white
paper [4] describing the technique. Mika also observes that Linux has
recognized several properties documented by Microsoft but not part of
the ACPI standard. There is discussion between Mika, Rafael, and Rajat
about seeking to align with Microsoft on the semantics of
=E2=80=9CDmaProperty=E2=80=9D for compatibility with firmware produced for =
Windows.

V2 of this patch series [5] again proposed an =E2=80=9CUntrustedDevice=E2=
=80=9D
property which Greg objects to because it is not sufficiently
descriptive, not sufficiently documented, and policies about trust
don=E2=80=99t belong in the kernel. Rajat describes the =E2=80=9Cuntrusted=
=E2=80=9D flag=E2=80=99s
current use, controlling IOMMU and Greg suggests naming the flag
=E2=80=9Cuse_iommu=E2=80=9D or =E2=80=9Cable to do DMA.=E2=80=9D

V3 of this patch series [6] proposes recognizing =E2=80=9CDmaProperty=E2=80=
=9D with
slightly altered semantics from Microsoft=E2=80=99s documentation. Greg
suggests adhering to Microsoft=E2=80=99s semantics for =E2=80=9CDmaProperty=
=E2=80=9D and to
introduce a new property with new semantics instead. Greg again states
that the flag being named =E2=80=9Cuntrusted=E2=80=9D is confusing.

V4 renames =E2=80=9Cuntrusted=E2=80=9D to =E2=80=9Cposes_dma_risk=E2=80=9D.=
 Christoph suggests
=E2=80=9Cuntrusted_dma=E2=80=9D and Rafael agrees.

V5 renames the flag to =E2=80=9Cuntrusted_dma=E2=80=9D. Bjorn asks for clar=
ification
about whether the semantics of this flag will match Microsoft=E2=80=99s
documentation. Rajat responds that Microsoft has agreed to update
their documentation to have aligned semantics, in particular =E2=80=9Cthe
property is not restricted to identify =E2=80=98internal PCIe hierarchies=
=E2=80=99
(starting at root port), but to "any PCI device". As of today,
Microsoft=E2=80=99s documentation does not appear to have been updated.

In V6 Rajat updates a link to Microsoft=E2=80=99s documentation, renames a
function to pci_dev_has_dma_property() and uses
acpi_dev_get_property() to read =E2=80=9CDmaProperty=E2=80=9D.

In V7 (Nov 2024) Joshua re-sends and Greg requests a summary of the
history of discussion about the name for the =E2=80=9Cuntrusted=E2=80=9D fl=
ag and
justification of the new name.

In V8 Joshua renames the =E2=80=9Cuntrusted=E2=80=9D flag to
=E2=80=9Crequires_dma_protection=E2=80=9D. Greg requests more information a=
bout the
threat model, what does this property convey, and why we should use
Microsoft=E2=80=99s DmaProperty and its semantics instead of inventing
something new.

In V9 Joshua updates the cover letter with more information from
previous submissions in this series and the =E2=80=9Cuntrusted=E2=80=9D fla=
g=E2=80=99s
introduction.

Links:
[1] https://lore.kernel.org/linux-arm-msm/20210624101557.v2.3.Icde6be7601a5=
939960caf802056c88cd5132eb4e@changeid/
[2] https://lore.kernel.org/lkml/20181129155153.35840-1-mika.westerberg@lin=
ux.intel.com/
[3] https://lore.kernel.org/all/20220120000409.2706549-1-rajatja@google.com=
/
[4] https://www.intel.com/content/dam/develop/external/us/en/documents/inte=
l-whitepaper-using-iommu-for-dma-protection-in-uefi-820238.pdf
[5] https://lore.kernel.org/all/20220202020103.2149130-1-rajatja@google.com=
/
[6] https://lore.kernel.org/all/20220216220541.1635665-1-rajatja@google.com=
/

Rajat Jain (2):
  PCI/ACPI: Support Microsoft's "DmaProperty"
  PCI: Rename pci_dev->untrusted to pci_dev->requires_dma_protection

 drivers/acpi/property.c     |  3 +++
 drivers/iommu/amd/iommu.c   |  3 +--
 drivers/iommu/dma-iommu.c   | 16 ++++++++--------
 drivers/iommu/intel/iommu.c | 10 +++++-----
 drivers/iommu/iommu.c       |  5 ++---
 drivers/pci/ats.c           |  2 +-
 drivers/pci/pci-acpi.c      | 22 ++++++++++++++++++++++
 drivers/pci/pci.c           |  2 +-
 drivers/pci/probe.c         | 10 +++++-----
 drivers/pci/quirks.c        |  4 ++--
 include/linux/pci.h         |  7 ++++---
 11 files changed, 54 insertions(+), 30 deletions(-)


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
--=20
2.48.1.601.g30ceb7b040-goog



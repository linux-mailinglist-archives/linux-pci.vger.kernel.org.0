Return-Path: <linux-pci+bounces-36689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3EB91F44
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F172A1F7B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584CD2E8DEA;
	Mon, 22 Sep 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R77rYcva"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7492E8B9F;
	Mon, 22 Sep 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555214; cv=none; b=nEPKn/MMW7Z6gF5i8KebDtygOuow2DlhORh+abB0JwnxCWC66rfUqde2hQJysEXVwvMkOXjTs5DKDp1nEkxludXra854KvOsu8BUL8PjGijbXdEQf20+0LEehYd1xEfjsmzMRxkTwCcJld1YsZHZqoMmP4qIoBXSHu1Fzlm4OWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555214; c=relaxed/simple;
	bh=jkLyg463Vj9+PNamEtH/GMXu9yQe7XDrh0jUJk0k1N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6ZqRkrRyZekmaDMByG7lKQXc9EkUlPH3nJ7gF8zUj0569BwCQ/AdkQqSvoIoQDN/3iI4BqkZ/qeZLbx3qR1V9FHESVACe+DqQbx/g580o2+W1uIrG4zSh1ewlckO9edgT1WAay9+RSmzdJzqGhPHR2MUGJ+FsH2E/R15E4nkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R77rYcva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39649C4CEF0;
	Mon, 22 Sep 2025 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555214;
	bh=jkLyg463Vj9+PNamEtH/GMXu9yQe7XDrh0jUJk0k1N8=;
	h=From:To:Cc:Subject:Date:From;
	b=R77rYcvac8SlRp4g9nv1iIJV3jY9ULKzE5lnr3Qy/NUa0y9RMozFMYTQ87ZCll6xy
	 osK+dVfxvzt+jE69IvGgoAVVatSYHMhK3QkVEEdFRqLbGcIMrKin/ax3HvEv5f2Y/k
	 MxasqLXAZoJruOpQd8ta6Gcsh2Ud3R0T3r6qsURTJsFPyiQ23DtvDCusHMu3MT2H7D
	 GAAhiKbBlFCBHC8JxHm3D/Sit/XlHSi6ahuwd4cdYZ5GKmEqe7sfd4OO2XGbaCYCUC
	 NkBCPjEFm4L430a2YdjREfwqZOddMJOuBehkJ/dTSdKmEb+D3QakQ71bvsOqScY4Ts
	 QEtVadkl3+nuA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 0/3] PM: runtime: Auto-cleanup macros for runtime PM
Date: Mon, 22 Sep 2025 17:26:54 +0200
Message-ID: <12763087.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is an update of

https://lore.kernel.org/linux-pm/6204724.lOV4Wx5bFT@rafael.j.wysocki/

that superseded both

https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/

and

https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/

The only patch in this series modified since the v2 is patch [1/3]: Two
additional class definition macros have been added to cover the case in
which resume failures can be neglected, new comments have been updated
to clarify usage conditions for the new macros, and the changelog has
been updated accordingly.

Thanks!





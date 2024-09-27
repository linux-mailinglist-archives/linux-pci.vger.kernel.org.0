Return-Path: <linux-pci+bounces-13602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17212988821
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF555283507
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2E613AD1C;
	Fri, 27 Sep 2024 15:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGI7GnG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657882481
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450454; cv=none; b=uXE7sU5J3rsfDVidiC3Y1iAs245/T7sB+ufzqRSOdqPF0h9sRULDA+XpVxPdsIaI5KCE7HUWRvOMyAEgy6t3/GT9M3uKEGXN6Hrg5Q487zohL3AWTywyt7dkez3IAnZBz0T5MKyZwKYjSRWfTZMmZGZDsfQVGPtNEP0Q6q93/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450454; c=relaxed/simple;
	bh=RPBb0ZvUs5Eo+vs4bgizIeIyKY0FI68D5Ug00hjYrZ0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V8ou6etl73E9fQhL1gLkBnVNiNoangsx7mpHAc98zoqaWJfmGR8JndZ+7Zi/XYCmHekwn0wLUWJZqN2lcRK6hOWdNBKf+0yNK637vS5pQBKrxFCmvm73cgSSpFK8waGdiJu2+4CJv8cQbtxr8NlXwo/c31xURbZ5WPLJL57om0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGI7GnG5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e21ac45b70so20366007b3.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727450452; x=1728055252; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RPBb0ZvUs5Eo+vs4bgizIeIyKY0FI68D5Ug00hjYrZ0=;
        b=LGI7GnG5vK7IB8NKHob20zdiB6wBcRRN11tF0D+PR14Jfu+fDKkilhVG+tBWE93g7D
         LhikiEgvGpB67XP56u3fI/RzMSbFTXUYY/jfGil9Yn5NwFQNGw7T2j5PjWOXfOWuJedS
         W2pRprYdDzwkgk4yNuWew6nIKv1FA7x3IizHveDUToP5FWWn9k9lXg5gd1k60zgycRJz
         gC/wV4eyqI73QuugFO5l6oQ2igCb75o9LxOuH6DaHyJD0yfVO3ys9DFV8UahDedvz0Ow
         PEG/OrR4YYTpQIcOk8zRf6hi1xaqzQYYNHdccwcBSJnqHZMFOSQQYU373DLDvtzRMgLE
         hDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450452; x=1728055252;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPBb0ZvUs5Eo+vs4bgizIeIyKY0FI68D5Ug00hjYrZ0=;
        b=w7AYueiqYxjRztqywXBuk1kuvjeXA18Uf7CsCJGcneAN0RTXOGGXxZvV5eOSyIIGr+
         +VtX/2B3fVxvCoD1J02+wTpx2dByOSazIvuF9WPp3a9t9umYFqF3GdBkaywbLTPPnfQP
         XjfAI6tMl3NyvNWKcrDSBzp3PWhYKP2gQJTWHiShRyadyKIbYrlZYabOk0LVgmqvTD7q
         UOOGyafvHAS6HDiF3FW3jG0b9ktYSZi/rccQQbtRTWoN9vtWf0tV+cIPNBVswb18OnG/
         BJ39XwWj69YKz0BWk3fciS6RDLLpmGCORhc4ve41yuFwSZNs2P6oQgtLNzsROGK8zA4Q
         hOwQ==
X-Gm-Message-State: AOJu0YzzuxTJQxaXanAiN7ju4LnpHgRH+eoQyzULCZbRj+u0hbrTyFyt
	ceJpEy+ohwcE2JhkBWbql4qDlKfVUQm53swUdEpcYGBnlOvK4MM4BidzIqy7qmxpGa35R7sWqJN
	XYsK9aBhNmcXQw2qfiqbDN5rZhhMkt0ZR
X-Google-Smtp-Source: AGHT+IFbt6pW1qlC4zYffuA8CTIBXDF7QNquM/dJAMgQWPWHch/h5E/nsxblrliw6AUuFu3nmjF9dVIAiJsfsCN8z0o=
X-Received: by 2002:a05:690c:6403:b0:646:7b75:5c2c with SMTP id
 00721157ae682-6e247546f2bmr34078347b3.16.1727450452326; Fri, 27 Sep 2024
 08:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Fri, 27 Sep 2024 20:50:41 +0530
Message-ID: <CALfBBTthgTJKZ+49rW7XKDp2xP6pDhSqPAgDsxczV_s00-Ov1A@mail.gmail.com>
Subject: pcie hotplug driver probe is not getting called
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello

Debugging a downstream port with slot capabilities indicating hotplug
capability is advertised in pci capability(id =0x10) .

None of the hotplug driver is getting invoked.

I assume pciehp_probe should've been called because its associated
with ".port_type = PCIE_ANY_PORT," in the pcie_port_service_driver
structure.

I assumed SHPC shpc_probe function would be called because the pci_id
table has PCI_CLASS_BRIDGE_PCI_NORMAL, but nothing related to hotplug
drivers is seen in the ftrace or dmesg.

Tried "pciehp.pciehp_force=1 pciehp.pciehp_debug=1" in the command
line but no luck

As part of port initialization if the hotplug capability is indicated
in the capability register the hotplug drivers should have been
invoked, but looks like its not the case.

Am I missing something?

Any information is appreciated.

Regards
Raghu


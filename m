Return-Path: <linux-pci+bounces-2421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DBB8365B2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9C28A8E1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1453120DF0;
	Mon, 22 Jan 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRJ3HRio"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B33D96B
	for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934597; cv=none; b=mgiait5zq7yfnCZ7jMQsyrqNdq+vlvCjjszba2YhDld/lc2NYzbE+K2fFRiC4EyCjhmzavkH0kZ52IaM30MjW0uZcoDaeK/R4nv4eE87bnYz3kPuNmU4Eo4pvRiGsh+NmvjeCdV4hvc1ogJO+qyvc48gzJ+3fcLQAZCEyh+ol+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934597; c=relaxed/simple;
	bh=1bCYhPgmI6PSb0c7/Nbpwr9CEkRnr3NsLIcKlUjtDKc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gw4xy9uiKJ34fH7aRqoE2Ma3kcUtgwmNttvOZpd2lMscpm9kOL3T+QnHgPjnFHR7u0GN9P3oTCJxLxuQEe7Uk23EprnTzVbc47Pjwz+fKefu86SB6IzVgVVH3Vt0EsyEZX+SjWUE5TOHTP3UmsqcHS93bOcV+tRXWl3C5OiqEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lRJ3HRio; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c5b5c163so1949239f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jan 2024 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705934593; x=1706539393; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLKGcjYNziLpYJx8DEHJXoX7hbusqCo8+fmev07YcQc=;
        b=lRJ3HRio8O3SlKrlt7u6BStGC32jZZCmv1v65lrMkVKOLrJaZR/pM45yauZ6SPnIEx
         C8ZZdeJm+MpzFLwH+caHS46ZBJZNO37HWC3g5/YPNNxUA5thQVCri8GJpnKrEcnO5W75
         /i8Ll91ogr5ZsdqrN6dKwGOgfTcm0kthiLOfjZyO53upWgS3hG6qfc1qDbrrTVZbozQi
         +R+/Tcx3X3V8L/gP8NJeE5T/VjM5zsMalI2FpNkuiT7dpjBQsc+50iuG6Vp5D3oEr3vL
         R9VurANlE7Y4Te/FeYXCjH13SFFKSx6TnMhaw0a0gShUljF6SsvpA2iBnWyMGuht0+O/
         0W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705934593; x=1706539393;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLKGcjYNziLpYJx8DEHJXoX7hbusqCo8+fmev07YcQc=;
        b=jQF0rZlejmFJVw02KfvPM+OLdT/o7Yh4/dL3OhHRAHK/a37wZDNrwRC7hdgHrDy3l4
         kNLOAzveTIyWKHt42NK6N2w/GqpvH6kjT6W1V5TUxuT1S11jtso8tok5m2ZE1LdMcvny
         RAyS7qnLdErhwpvv6vZCgRkQxZFohcQQ6xDnNwBF6yyOvaP5QIxLltq9F/LMq59NjDw7
         RT7qX48sm3i9pBZy3n1vCm60Mgh4zzAYi3G1FTUYc+zv8X7bdh3+bqrCDqWB2ZqTelhw
         7ZQcczfuMbu30lWMO8jqEcbDEdpn/HvV/cr3ZmlKJDDqGtPI6HhXK12SAyzMLrlAcz30
         Qb9A==
X-Gm-Message-State: AOJu0Ywrra3meATkyFl4vEmlXFChOMICLl1bJ1egxgOsOP6QIW6K4HCl
	QhzOMdobzrxKo15KRIN0z5A4CK8aD1EqMFbv69KSL3uiXxue+D2wqquunNn4Tr4=
X-Google-Smtp-Source: AGHT+IFiae/b6xmgfkZ632PsFZd74HZSeHBAm/8QKjNJUuN8n8mzxih+epz8zkalE8leQo+zyOAaBQ==
X-Received: by 2002:adf:fac6:0:b0:337:bdf7:2e32 with SMTP id a6-20020adffac6000000b00337bdf72e32mr1591570wrs.23.1705934593446;
        Mon, 22 Jan 2024 06:43:13 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d67d1000000b003392f229b60sm4346652wrw.40.2024.01.22.06.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:43:12 -0800 (PST)
Date: Mon, 22 Jan 2024 17:43:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [bug report] Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
Message-ID: <29ee741c-7fbd-4061-87c6-c4ae46c372c1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Bjorn Helgaas,

The patch f93e71aea6c6: "Revert "PCI/ASPM: Remove
pcie_aspm_pm_state_change()"" from Jan 1, 2024 (linux-next), leads to
the following Smatch static checker warning:

	drivers/pci/pcie/aspm.c:1017 pcie_aspm_pm_state_change()
	warn: sleeping in atomic context

drivers/pci/pcie/aspm.c
    1007 void pcie_aspm_pm_state_change(struct pci_dev *pdev)
    1008 {
    1009         struct pcie_link_state *link = pdev->link_state;
    1010 
    1011         if (aspm_disabled || !link)
    1012                 return;
    1013         /*
    1014          * Devices changed PM state, we should recheck if latency
    1015          * meets all functions' requirement
    1016          */
--> 1017         down_read(&pci_bus_sem);

This is a revert from a patch from 2022 which was before I had written
this "sleeping in atomic" static checker thing.

    1018         mutex_lock(&aspm_lock);
    1019         pcie_update_aspm_capable(link->root);
    1020         pcie_config_aspm_path(link);
    1021         mutex_unlock(&aspm_lock);
    1022         up_read(&pci_bus_sem);
    1023 }

The call trees that Smatch is complaining about are:

vortex_boomerang_interrupt() <- disables preempt
-> _vortex_interrupt()
-> _boomerang_interrupt()
   -> vortex_error()
      -> vortex_up()
velocity_suspend() <- disables preempt
-> velocity_set_power_state()
         -> pci_set_power_state()
            -> pci_set_low_power_state()
               -> pcie_aspm_pm_state_change()

So what Smatch is saying is the vortex_boomerang_interrupt() and
velocity_suspend() hold spin locks and then set the power state.  The
call trees are quite long so I'm not really able to be sure if this is
a false positive or not...  I wish this warning were more useful.

These emails are a one time thing.  Just reply if it's a false positive
and I'll note it down.  Otherwise feel free to ignore it.

regards,
dan carpenter


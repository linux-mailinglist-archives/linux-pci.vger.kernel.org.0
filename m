Return-Path: <linux-pci+bounces-2051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E282AE02
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FF228330A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D47156C5;
	Thu, 11 Jan 2024 11:56:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B41154B6;
	Thu, 11 Jan 2024 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbc5636b8eso3279063b6e.2;
        Thu, 11 Jan 2024 03:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704974209; x=1705579009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRRot3fSPqM/q7yv55Kx8nQqL7oWPBUmdwcMoAjnDzI=;
        b=f3d3u6E6haVdNUl1q1DGEmanBsFJVarbPa+P8lPLm8quExTXEz1sL12OXkURHULrlW
         1j/hmVlOZc/PBUhScAaZx8eGtzXDgHfRmt9SMNniew1g8WOCv5TxYJGPU2RoTg9aW1B0
         7vAJRHELmlSXb/pO2nM/Y86RHmqFu4I81b0bUTZdxNV7nPmukDjSpqKZ0igk1UQtj3wr
         io0XonpKomaDJL8p4BWLP+2OliWdOR1pJXfi97GUIiArjbIJGgErxyayaPX0wIkviSU7
         ceV8JJwNPkK3Qz1GI5PQhpRkzr2HHfym6mr/rEJ6FTV+MOLbF9DsgRB+Y7iKHA8MjV8r
         bBWQ==
X-Gm-Message-State: AOJu0YwoeXqoi87P9TP2xitmzNUXtLpJxmSVu5j58VuCI6pkeSE/HGj+
	0Xnyou13VhGFZ8/r9JP3Nrw=
X-Google-Smtp-Source: AGHT+IH6QIRblUbO7LPVLGc5KQtSUtO/9V3RZZMWBTBUf/ouMAQIu3s88JmEiW1PahzxYrrxcTHaSg==
X-Received: by 2002:a05:6808:3987:b0:3bb:c56e:7f6b with SMTP id gq7-20020a056808398700b003bbc56e7f6bmr1267990oib.56.1704974209024;
        Thu, 11 Jan 2024 03:56:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id le5-20020a056a004fc500b006db00cb78a8sm997489pfb.179.2024.01.11.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:56:48 -0800 (PST)
Date: Thu, 11 Jan 2024 20:56:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20240111115646.GA1443933@rocinante>
References: <20231113185607.1756-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113185607.1756-1-james.quinlan@broadcom.com>

Hello,

> V8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
>    -- Squashed last two commits of v7 (Bjorn)
>    -- Fix DT binding description text wrapping (Bjorn)
>    -- Fix incorrect Spec reference (Bjorn)
>          s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
>    -- Text substitutions (Bjorn)
>          s/WRT/With respect to/ 
>          s/Tclron/T_CLRon/
> 
> v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
>       network phy-mode and (b) keeping the code simple (not counting clkreq
>       signal appearances, un-advertising capabilites, etc).  This is
>       what I have done.  The property is now "brcm,clkreq-mode" and
>       the values may be one of "safe", "default", and "no-l1ss".  The
>       default setting is to employ the most capable power savings mode.
> 
> v6 -- No code has been changed.
>    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
>    -- Changed sign-off and author email address for all commits.
>       This was due to a change in Broadcom's upstreaming policy.
> 
> v5 -- Remove DT property "brcm,completion-timeout-us" from	 
>       "DT bindings" commit.  Although this error may be reported	 
>       as a completion timeout, its cause was traced to an	 
>       internal bus timeout which may occur even when there is	 
>       no PCIe access being processed.  We set a timeout of four	 
>       seconds only if we are operating in "L1SS CLKREQ#" mode.
>    -- Correct CEM 2.0 reference provided by HW engineer,
>       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
>    -- Add newline to dev_info() string (Stefan)
>    -- Change variable rval to unsigned (Stefan)
>    -- s/implementaion/implementation/ (Bjorn)
>    -- s/superpowersave/powersupersave/ (Bjorn)
>    -- Slightly modify message on "PERST#" commit.
>    -- Rebase to torvalds master
> 
> v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
>       driver probe() time.  This is done in Raspian Linux and its
>       absence may be the cause of a failing test case.
>    -- New commit that removes stale comment.
> 
> v3 -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
>    -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
>    -- Put binding names in DT commit Subject (Bjorn)
>    -- Add a verb to a commit's subject line (Bjorn)
>    -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
>    -- Rewrote commit msgs and comments refering panics if L1SS
>       is enabled/disabled; the code snippet that unadvertises L1SS
>       eliminates the panic scenario. (Bjorn)
> 
> v2 -- Changed binding property 'brcm,completion-timeout-msec' to
>       'brcm,completion-timeout-us'.  (StefanW for standard suffix).
>    -- Warn when clamping timeout value, and include clamped
>       region in message. Also add min and max in YAML. (StefanW)
>    -- Qualify description of "brcm,completion-timeout-us" so that
>       it refers to PCIe transactions. (StefanW)
>    -- Remvove mention of Linux specifics in binding description. (StefanW)
>    -- s/clkreq#/CLKREQ#/g (Bjorn)
>    -- Refactor completion-timeout-us code to compare max and min to
>       value given by the property (as opposed to the computed value).
> 
> v1 -- The current driver assumes the downstream devices can
>       provide CLKREQ# for ASPM.  These commits accomodate devices
>       w/ or w/o clkreq# and also handle L1SS-capable devices.
> 
>    -- The Raspian Linux folks have already been using a PCIe RC
>       property "brcm,enable-l1ss".  These commits use the same
>       property, in a backward-compatible manner, and the implementaion
>       adds more detail and also automatically identifies devices w/o
>       a clkreq# signal, i.e. most devices plugged into an RPi CM4
>       IO board.

Applied to controller/broadcom, thank you!

[01/02] dt-bindings: PCI: brcmstb: Add property "brcm,clkreq-mode"
        https://git.kernel.org/pci/pci/c/14b15aeb3628
[02/02] PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device
        https://git.kernel.org/pci/pci/c/e2596dcf1e9d

	Krzysztof


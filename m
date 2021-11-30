Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54140462E2B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 09:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbhK3IGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 03:06:53 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:39449 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbhK3IGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 03:06:52 -0500
Received: by mail-pg1-f180.google.com with SMTP id r5so18883736pgi.6;
        Tue, 30 Nov 2021 00:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=44H9x6jq/cDKCVfT3PAwIodg8SUeceQE3Ngyr/m8zEc=;
        b=a5UI5kPx5PFOIOe2ZFPXqaCipfwnXRmi0HqYfvneJJjSaA9w7RuRT70QLvUcKmxM1u
         Qxa3it+Mu+8zQRiqcWTMP27sSextSJHFOOiAtPe7JIJyNVrhAqEq7FZOr0Yz23alNjoo
         3dtIG91+eZw9540yb4RlYVp+YfDmQ9WVP8SBExYEHUDdUJSSC2hsLUbcjlXj642ywGy3
         kDKyOYV0ky6Fkt2XQGzIt46S1RcGXu9ts7g+B06v74anfxNjZotBQd4I+YvEZhu9omOM
         VSZ/2f48SvwWggwEaNofQAsfAy4Rifi/UgENm3+rqfdYQHRvf/DPMuyGEc26PvI0YXEz
         hwiw==
X-Gm-Message-State: AOAM532w8tinDSLZu48sb74zVfZnMHrzETOVAvf0sD5q+5JyrmIPodIw
        0VMyjelwy3NzwPtVH+iXQDM=
X-Google-Smtp-Source: ABdhPJxon6fCisjjARBWiIfZe1fuI6GCGyDOolG9YhuP1agxDgt8lsRz1jUpKo9w92Em3V8oyEJEDQ==
X-Received: by 2002:a05:6a00:1a4f:b0:4a3:3c4a:b708 with SMTP id h15-20020a056a001a4f00b004a33c4ab708mr44447918pfv.29.1638259413674;
        Tue, 30 Nov 2021 00:03:33 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o134sm18578612pfg.1.2021.11.30.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 00:03:33 -0800 (PST)
Date:   Tue, 30 Nov 2021 09:03:23 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/ASPM: Add ASPM BIOS override function
Message-ID: <YaXay7MkIybYz4uI@rocinante>
References: <20211120015756.1396263-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120015756.1396263-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi David,

[...]
> @@ -562,11 +562,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pcie_aspm_policy_override(struct pci_dev *dev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> +static inline void pcie_aspm_policy_override(struct pci_dev *dev) {}
>  #endif

A small nitpick, and a slight OCD on my part, so feel free to ignore this,
of course: a missing space between curly brackets, to keep things aligned
with previous definitions.

> @@ -1140,6 +1140,24 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> +void pcie_aspm_policy_override(struct pci_dev *pdev)
> +{
> +	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
> +
> +	down_read(&pci_bus_sem);
> +	mutex_lock(&aspm_lock);
> +
> +	if (link) {
> +		link->aspm_default = ASPM_STATE_ALL;
> +		pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +		pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +	}
> +
> +	mutex_unlock(&aspm_lock);
> +	up_read(&pci_bus_sem);
> +}
> +EXPORT_SYMBOL(pcie_aspm_policy_override);

What about the following version where if we have no link (albeit, I am not
sure how often this is going to be the case?) then we don't even attempt to
get a hold on the lock and such:

	void pcie_aspm_policy_override(struct pci_dev *pdev)
	{
		struct pcie_link_state *link = pcie_aspm_get_link(pdev);
	
		if (!link)
			return;
	
		down_read(&pci_bus_sem);
		mutex_lock(&aspm_lock);
	
		link->aspm_default = ASPM_STATE_ALL;
		pcie_config_aspm_link(link, policy_to_aspm_state(link));
		pcie_set_clkpm(link, policy_to_clkpm_state(link));
	
		mutex_unlock(&aspm_lock);
		up_read(&pci_bus_sem);
	}

What do you think?  Would this make sense?

	Krzysztof

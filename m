Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0404641E487
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346870AbhI3XCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 19:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344543AbhI3XCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 19:02:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB46C61A63;
        Thu, 30 Sep 2021 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633042849;
        bh=5qgapm9VVV5p1sXe/lQdYQ41rEq5iv4RtFtLTYvTtOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z9eoJfcyOrg7Gzl8Y4ovM9rrjfofA5YqitC2RLdI/IJ6gftF40SbkMNZOGC1FhOIl
         Ny8aj3uYkJGBFlmFoUyjSB5qh6m9GWUH31oelP/aIrvX2yFIHC19Wb8VavOJxrpRoC
         j8MLaXnpYU8KsnATFIhmQmilljJn7smy4JgmX+Wk141OPLx9u/SjvAl97ksSTT0PAc
         pGw71UKdR8+pSVBV1wbDK0JekVuGzXAczX5wDdeH8zFhpg2ag1H1swNkf07pZwpnPV
         aPWz5B0tLU3D5TyFnpqJQMFQoqqnGknETZP4WyA9rVraD2EcKeg+WN/DFqmOL86sZ6
         6YEj4v5K9ILGw==
Date:   Thu, 30 Sep 2021 18:00:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] PCI/ASPM: Remove unncessary linked list from
 aspm.c
Message-ID: <20210930230047.GA921465@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004315.22558-5-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:43:15AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> aspm.c defines a linked list - `link_list` and stores each of
> its node in struct pcie_link_state.sibling. This linked list
> tracks devices for which the struct pcie_link_state object
> was successfully created. It is used to loop through the list
> for instance to set ASPM policy or update changes. However, it
> is possible to access these devices via existing lists defined
> inside pci.h
> 
> This patch:
> - removes link_list and struct pcie_link_state.sibling
> - accesses child devices via struct pci_dev.bust_list
> - accesses all PCI buses via pci_root_buses on struct pci_bus.node

Again, I LOVE the way this is going.  I depise this extra linked list.

> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 56d4fe7d50b5..4bef652dc63c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -48,7 +48,6 @@ struct aspm_latency {
>  
>  struct pcie_link_state {
>  	struct pci_dev *pdev;		/* Upstream component of the Link */
> -	struct list_head sibling;	/* node in link_list */
>  
>  	/* ASPM state */
>  	u32 aspm_support:7;		/* Supported ASPM state */
> @@ -76,7 +75,6 @@ struct pcie_link_state {
>  static int aspm_disabled, aspm_force;
>  static bool aspm_support_enabled = true;
>  static DEFINE_MUTEX(aspm_lock);
> -static LIST_HEAD(link_list);
>  
>  #define POLICY_DEFAULT 0	/* BIOS default setting */
>  #define POLICY_PERFORMANCE 1	/* high performance */
> @@ -880,10 +878,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  	if (!link)
>  		return NULL;
>  
> -	INIT_LIST_HEAD(&link->sibling);
>  	link->pdev = pdev;
> -
> -	list_add(&link->sibling, &link_list);
>  	pdev->link_state = link;
>  	return link;
>  }
> @@ -970,24 +965,22 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  {
>  	struct pcie_link_state *link;
>  	struct pci_dev *dev, *root_dev;
> +	struct pci_bus *rootbus = root->pdev->bus;
>  
>  	/* Ensure it is the root device */
>  	root_dev = pcie_get_root(root->pdev);
>  	root = root_dev ? root_dev->link_state : NULL;
>  
> -	list_for_each_entry(link, &link_list, sibling) {
> -		dev = pcie_get_root(link->pdev);
> -		if (dev->link_state != root)
> +	list_for_each_entry(dev, &rootbus->devices, bus_list) {
> +		if (!dev->link_state)
>  			continue;
>  
> -		link->aspm_capable = link->aspm_support;
> +		dev->link_state->aspm_capable = link->aspm_support;
>  	}
> -	list_for_each_entry(link, &link_list, sibling) {
> +
> +	list_for_each_entry(dev, &rootbus->devices, bus_list) {
>  		struct pci_dev *child;
> -		struct pci_bus *linkbus = link->pdev->subordinate;
> -		dev = pcie_get_root(link->pdev);
> -		if (dev->link_state != root)
> -			continue;
> +		struct pci_bus *linkbus = dev->subordinate;
>  
>  		list_for_each_entry(child, &linkbus->devices, bus_list) {
>  			if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
> @@ -1024,7 +1017,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  
>  	/* All functions are removed, so just disable ASPM for the link */
>  	pcie_config_aspm_link(link, 0);
> -	list_del(&link->sibling);
>  	/* Clock PM is for endpoint device */
>  	free_link_state(link);
>  
> @@ -1164,6 +1156,8 @@ static int pcie_aspm_set_policy(const char *val,
>  {
>  	int i;
>  	struct pcie_link_state *link;
> +	struct pci_bus *bus;
> +	struct pci_dev *pdev;
>  
>  	if (aspm_disabled)
>  		return -EPERM;
> @@ -1176,9 +1170,18 @@ static int pcie_aspm_set_policy(const char *val,
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	aspm_policy = i;
> -	list_for_each_entry(link, &link_list, sibling) {
> -		pcie_config_aspm_link(link, policy_to_aspm_state(link));
> -		pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +	list_for_each_entry(bus, &pci_root_buses, node) {
> +		list_for_each_entry(pdev, &bus->devices, bus_list) {
> +			if (!pci_is_pcie(pdev))
> +				break;
> +
> +			link = pdev->link_state;
> +			if (!link)
> +				continue;
> +
> +			pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +			pcie_set_clkpm(link, policy_to_clkpm_state(link));
> +		}

IIUC, in the existing code, link_list contains *every* pcie_link_state
in the system, so we update the configuration of all of them.

Here, iterating through pci_root_buses gives us all the root buses (in
the case of multiple host bridges), and on each root bus we look at
every device that has a link_state, so those would typically be Root
Ports.  But I don't think we descend the hierarchy, so in the case of
deeper hierarchies, I don't think we update the lower levels.

Example from my laptop:

  00:1d.6 Root Port                     to [bus 06-3e]
  06:00.0 Upstream Port   (switch A)    to [bus 07-3e]
  07:01.0 Downstream Port (switch A)    to [bus 09-3d]
  09:00.0 Upstream Port   (switch B)    to [bus 0a-3d]
  0a:04.0 Downstream Port (switch B)    to [bus 0c-3d]
  0c:00.0 Upstream Port   (switch C)    to [bus 0d-3d]
  0d:01.0 Downstream Port (switch C)    to [bus 0e]
  0e:00.0 Upstream Port   (Endpoint)    USB controller

Here there are four links:

  00:1d.6 --- 06:00.0
  07:01.0 --- 09:00.0
  0a:04.0 --- 0c:00.0
  0d:01.0 --- 0e:00.0

But I think this patch only looks at the 00:1d.6 --- 06:00.0 link,
doesn't it?

>  	}
>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
> -- 
> 2.20.1
> 

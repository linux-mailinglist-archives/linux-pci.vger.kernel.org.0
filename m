Return-Path: <linux-pci+bounces-3867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF285F866
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB000B230C3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91F162142;
	Thu, 22 Feb 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOSb7oBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44A612DD84;
	Thu, 22 Feb 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605650; cv=none; b=DwIXRGLfcUizxUbqS8QZgPRPVLbJSPbUPWJQlfKNRbNl+fKWpTRxrmXX9n2/+j0zJOOmBzE/ezJdN16Hv4cVPDy1bUKjy3nHFJm2OFXLtbpYgx3DE7pXpbotSJjQqml6x/qSSzD7o/rw1cCR+oFoYS2N9uPlGTQT/URwipwDK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605650; c=relaxed/simple;
	bh=eajeQHvLMChOHRIay40XPtkfd6ypiOKuXZP+1OEM90s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANsI3MQsFX5AB1v8PDvkzDmh0Ll/jT6XeQUT+n8tSHVAk8xc1JYzbtp7osLV3onoovsMddfLeObtDByx6R2Ud9CrGkinGn6i9BrUFFw/Tj4Y3pDKHrebq7FwHFsDSz2t8Wjdd0cEAiBe/owYPGPu0AEI3dzLhiLJTsu7ShVnzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOSb7oBJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708605649; x=1740141649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eajeQHvLMChOHRIay40XPtkfd6ypiOKuXZP+1OEM90s=;
  b=MOSb7oBJRY7mIMioKDpfk8H2Ym10HnFc0iDbbyiLuPb6npBfvZG7VlZ9
   pCPYj+YKM8M0uXeWzLMHX13MDd6TG5DhXtRy4F/8ISwsM/wb6Dmn2j4s2
   znT43diIGubLfFTKmHQ5QAiBwAkQ59SiuFev36Un8mfki18/L0KS/R8/0
   dSLxlH6zT1Lh9Uo81C0kwrTAgZcxGmmZX/d+CqKHo0vE+uMoecPM6POUv
   CD9hFLgc9tOSAGCvrJ91CIGdoDC6asJ4vz32q/3sGSy1M0j0mvPYZA64h
   mAR4tRnshRiQNXuRGQzaCY/p0PELkl5LZzr0zrhF6HsydXxqjzgRPxrOl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2690260"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2690260"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913516993"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913516993"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2024 04:40:42 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd8NC-0006JM-23;
	Thu, 22 Feb 2024 12:40:31 +0000
Date: Thu, 22 Feb 2024 20:39:30 +0800
From: kernel test robot <lkp@intel.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, Nitesh Gupta <nitegupt@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Message-ID: <202402222044.JXTN6nr0-lkp@intel.com>
References: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>

Hi root,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next mani-mhi/mhi-next linus/master v6.8-rc5 next-20240221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/root/dt-bindings-PCI-qcom-Add-global-irq-support-for-SA8775p/20240221-220722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240221140405.28532-4-root%40hu-msarkar-hyd.qualcomm.com
patch subject: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller level PCIe errors
config: i386-buildonly-randconfig-005-20240222 (https://download.01.org/0day-ci/archive/20240222/202402222044.JXTN6nr0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402222044.JXTN6nr0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402222044.JXTN6nr0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-qcom.c:1753:6: warning: format specifies type 'unsigned long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
    1751 |                         len += sysfs_emit_at(buf, len, "%s: %lu\n",
         |                                                             ~~~
         |                                                             %u
    1752 |                                         pcie_fault_string[i],
    1753 |                                         pcie_fault[i]);
         |                                         ^~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:1758:6: warning: format specifies type 'unsigned long' but the argument has type 'u32' (aka 'unsigned int') [-Wformat]
    1756 |         len += sysfs_emit_at(buf, len, "%s: %lu\n",
         |                                             ~~~
         |                                             %u
    1757 |                                         pcie_fault_string[i],
    1758 |                                         pcie->pcie_fault_total);
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-qcom.c:1902:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
    1902 |         sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
         |         ^~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.


vim +1753 drivers/pci/controller/dwc/pcie-qcom.c

  1739	
  1740	static ssize_t qcom_pcie_error_report_show(struct device *dev,
  1741			struct device_attribute *attr,
  1742			char *buf)
  1743	{
  1744		unsigned int i;
  1745		struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(dev);
  1746		u32 *pcie_fault = pcie->pcie_fault;
  1747		size_t len = 0;
  1748	
  1749		for (i = 0; i < MAX_PCIE_SAFETY_FAULT; i++) {
  1750			if (pcie_fault_string[i])
  1751				len += sysfs_emit_at(buf, len, "%s: %lu\n",
  1752						pcie_fault_string[i],
> 1753						pcie_fault[i]);
  1754		}
  1755	
  1756		len += sysfs_emit_at(buf, len, "%s: %lu\n",
  1757						pcie_fault_string[i],
> 1758						pcie->pcie_fault_total);
  1759	
  1760		return len;
  1761	}
  1762	static DEVICE_ATTR_RO(qcom_pcie_error_report);
  1763	
  1764	static struct attribute *qcom_pcie_attrs[] = {
  1765		&dev_attr_qcom_pcie_error_report.attr,
  1766		NULL,
  1767	};
  1768	
  1769	static const struct attribute_group qcom_pcie_attribute_group = {
  1770		.attrs = qcom_pcie_attrs,
  1771		.name = "qcom_pcie"
  1772	};
  1773	
  1774	static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
  1775	{
  1776		struct dw_pcie *pci = pcie->pci;
  1777		struct device *dev = pci->dev;
  1778		char *name;
  1779	
  1780		name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
  1781		if (!name)
  1782			return;
  1783	
  1784		pcie->debugfs = debugfs_create_dir(name, NULL);
  1785		debugfs_create_devm_seqfile(dev, "link_transition_count", pcie->debugfs,
  1786					    qcom_pcie_link_transition_count);
  1787	}
  1788	
  1789	static int qcom_pcie_probe(struct platform_device *pdev)
  1790	{
  1791		const struct qcom_pcie_cfg *pcie_cfg;
  1792		struct device *dev = &pdev->dev;
  1793		struct qcom_pcie *pcie;
  1794		struct dw_pcie_rp *pp;
  1795		struct resource *res;
  1796		struct dw_pcie *pci;
  1797		int ret;
  1798	
  1799		pcie_cfg = of_device_get_match_data(dev);
  1800		if (!pcie_cfg || !pcie_cfg->ops) {
  1801			dev_err(dev, "Invalid platform data\n");
  1802			return -EINVAL;
  1803		}
  1804	
  1805		pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
  1806		if (!pcie)
  1807			return -ENOMEM;
  1808	
  1809		pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
  1810		if (!pci)
  1811			return -ENOMEM;
  1812	
  1813		pm_runtime_enable(dev);
  1814		ret = pm_runtime_get_sync(dev);
  1815		if (ret < 0)
  1816			goto err_pm_runtime_put;
  1817	
  1818		pci->dev = dev;
  1819		pci->ops = &dw_pcie_ops;
  1820		pp = &pci->pp;
  1821	
  1822		pcie->pci = pci;
  1823	
  1824		pcie->cfg = pcie_cfg;
  1825	
  1826		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
  1827		if (IS_ERR(pcie->reset)) {
  1828			ret = PTR_ERR(pcie->reset);
  1829			goto err_pm_runtime_put;
  1830		}
  1831	
  1832		pcie->global_irq = platform_get_irq_byname(pdev, "global");
  1833		if (pcie->global_irq < 0) {
  1834			ret = pcie->global_irq;
  1835			goto err_pm_runtime_put;
  1836		}
  1837	
  1838		ret = devm_request_threaded_irq(dev, pcie->global_irq, NULL,
  1839					qcom_pcie_global_irq_thread,
  1840					IRQF_ONESHOT,
  1841					"global_irq", pcie);
  1842		if (ret) {
  1843			dev_err(dev, "Failed to request Global IRQ\n");
  1844			goto err_pm_runtime_put;
  1845		}
  1846	
  1847		pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
  1848		if (IS_ERR(pcie->parf)) {
  1849			ret = PTR_ERR(pcie->parf);
  1850			goto err_pm_runtime_put;
  1851		}
  1852	
  1853		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
  1854		if (IS_ERR(pcie->elbi)) {
  1855			ret = PTR_ERR(pcie->elbi);
  1856			goto err_pm_runtime_put;
  1857		}
  1858	
  1859		/* MHI region is optional */
  1860		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
  1861		if (res) {
  1862			pcie->mhi = devm_ioremap_resource(dev, res);
  1863			if (IS_ERR(pcie->mhi)) {
  1864				ret = PTR_ERR(pcie->mhi);
  1865				goto err_pm_runtime_put;
  1866			}
  1867		}
  1868	
  1869		pcie->phy = devm_phy_optional_get(dev, "pciephy");
  1870		if (IS_ERR(pcie->phy)) {
  1871			ret = PTR_ERR(pcie->phy);
  1872			goto err_pm_runtime_put;
  1873		}
  1874	
  1875		ret = qcom_pcie_icc_init(pcie);
  1876		if (ret)
  1877			goto err_pm_runtime_put;
  1878	
  1879		ret = pcie->cfg->ops->get_resources(pcie);
  1880		if (ret)
  1881			goto err_pm_runtime_put;
  1882	
  1883		pp->ops = &qcom_pcie_dw_ops;
  1884	
  1885		ret = phy_init(pcie->phy);
  1886		if (ret)
  1887			goto err_pm_runtime_put;
  1888	
  1889		platform_set_drvdata(pdev, pcie);
  1890	
  1891		ret = dw_pcie_host_init(pp);
  1892		if (ret) {
  1893			dev_err(dev, "cannot initialize host\n");
  1894			goto err_phy_exit;
  1895		}
  1896	
  1897		qcom_pcie_icc_update(pcie);
  1898	
  1899		if (pcie->mhi)
  1900			qcom_pcie_init_debugfs(pcie);
  1901	
> 1902		sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
  1903	
  1904		return 0;
  1905	
  1906	err_phy_exit:
  1907		phy_exit(pcie->phy);
  1908	err_pm_runtime_put:
  1909		pm_runtime_put(dev);
  1910		pm_runtime_disable(dev);
  1911	
  1912		return ret;
  1913	}
  1914	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

